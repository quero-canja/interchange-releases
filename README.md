# Canja Interchange

Versões do app para Mac do Canja Interchange, ferramenta interna da Canja Audio Culture para abrir e validar OMF e AAF.

O app só funciona com login de uma conta @canja.audio. O código não fica neste repositório.

## Instalar

No Terminal:

```
curl -fsSL https://raw.githubusercontent.com/quero-canja/interchange-releases/main/install.sh | bash
```

Depois disso o app se atualiza sozinho: toda vez que abre, ele confere se tem versão nova.

## Como funciona

- `latest.json` diz qual é a versão mais nova. `latest.json.sig` é a assinatura dele, feita com a chave da Canja. O app recusa qualquer versão sem assinatura válida.
- Cada versão fica em Releases.

Software proprietário da Canja Audio Culture. Uso interno.
