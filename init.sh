dados_enem="microdados_enem_"


for i in {2019..2022}; do
  if [[ ! -d "$dados_enem$i" ]]; then
    zip="$dados_enem$i.zip"
    if [[ ! -f $zip ]]; then
      curl -o "$zip" "https://download.inep.gov.br/microdados/microdados_enem_$i.zip"
    fi
    7z x "$dados_enem$i.zip" -o"$dados_enem$i"
    if [[ -d "$dados_enem$i" ]]; then
      rm -f "$dados_enem$i.zip"
    fi
    grep -Fq "$dados_enem$i/" .gitignore || echo "$dados_enem$i/" >> .gitignore
  fi
done

