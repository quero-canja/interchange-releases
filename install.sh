#!/bin/bash
# Canja Interchange: instalador para Mac (uso interno da Canja).
# Uso, no Terminal:
#   curl -fsSL https://raw.githubusercontent.com/quero-canja/interchange-releases/main/install.sh | bash
set -euo pipefail
T="$(mktemp -d)"; trap 'rm -rf "$T"' EXIT
echo "Canja Interchange: procurando a versão mais nova..."
curl -fsSL "https://github.com/quero-canja/interchange-releases/releases/latest/download/latest.json" -o "$T/latest.json"
URL=$(plutil -extract url raw -o - "$T/latest.json")
SHA=$(plutil -extract sha256 raw -o - "$T/latest.json")
VER=$(plutil -extract version raw -o - "$T/latest.json")
case "$URL" in https://github.com/quero-canja/interchange-releases/*) ;; *) echo "Endereço de download inesperado. Nada foi instalado."; exit 1;; esac
echo "Baixando a versão $VER..."
curl -fL --progress-bar "$URL" -o "$T/app.zip"
echo "$SHA  $T/app.zip" | shasum -a 256 -c - >/dev/null 2>&1 || { echo "O arquivo baixado não confere com o publicado pela Canja. Nada foi instalado."; exit 1; }
mkdir "$T/x"; ditto -x -k "$T/app.zip" "$T/x"
codesign --verify --deep --strict "$T/x/Canja Interchange.app" || { echo "O app não passou na conferência. Nada foi instalado."; exit 1; }
DEST=/Applications
[ -w "$DEST" ] || { DEST="$HOME/Applications"; mkdir -p "$DEST"; }
pkill -x "Canja Interchange" 2>/dev/null && sleep 1 || true
rm -rf "$DEST/Canja Interchange.app"
mv "$T/x/Canja Interchange.app" "$DEST/"
xattr -dr com.apple.quarantine "$DEST/Canja Interchange.app" 2>/dev/null || true
echo "Pronto: Canja Interchange $VER instalado em $DEST. Abrindo..."
open "$DEST/Canja Interchange.app"
