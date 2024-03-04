#!/bin/bash

echo "Procurando por dados do ENEM na pasta do projeto"
dados_enem="microdados_enem_"
for i in {2019..2022}; do
  if [[ ! -d "$dados_enem$i" ]]; then
    zip="$dados_enem$i.zip"
    echo "Dados do ENEM $i não encontrados, procurando arquivo $zip"
    if [[ ! -f $zip ]]; then
      echo "Arquivo $zip não encontrado, baixando do site do INEP"
      curl -o "$zip" "https://download.inep.gov.br/microdados/microdados_enem_$i.zip"
    fi
    if command -v 7z >/dev/null 2>&1; then
      echo "Extraindo arquivo $zip com 7z"
      7z x "$dados_enem$i.zip" -o"$dados_enem$i"
      if [[ -d "$dados_enem$i" ]]; then
        echo "Pasta $dados_enem$i extraído com sucesso, deletando arquivo $zip"
        rm -f "$dados_enem$i.zip"
      fi
    else
      echo "Instale 7z ou extraia o arquivo $zip manualmente"
    fi
    echo "Adicionando $dados_enem$i/ ao .gitignore"
    grep -Fq "$dados_enem$i/" .gitignore || echo "$dados_enem$i/" >> .gitignore
  fi
done
echo "Dados do ENEM encontrados e prontos para uso"

