@echo off

rem Procurando por dados do ENEM na pasta do projeto
set "dados_enem=microdados_enem_"

rem Loop para anos de 2019 a 2022
for /l %%i in (2019,1,2022) do (

  rem Verifica se a pasta do ano existe
  if not exist "%dados_enem%%%i%" (

    rem Define o nome do arquivo ZIP
    set "zip=%dados_enem%%%i%.zip"

    rem Verifica se o arquivo ZIP existe
    if not exist "%zip%" (

      rem Baixa o arquivo ZIP do site do INEP
      echo Baixando arquivo %zip% do site do INEP
      curl -o "%zip%" "https://download.inep.gov.br/microdados/microdados_enem_%i.zip"

    )

    rem Verifica se o 7z está instalado
    if exist "C:\Program Files\7-Zip\7z.exe" (

      rem Extrai o arquivo ZIP com 7z
      echo Extraindo arquivo %zip% com 7z
      "C:\Program Files\7-Zip\7z.exe" x "%zip%" -o"%dados_enem%%%i%"

      rem Verifica se a pasta foi extraída com sucesso
      if exist "%dados_enem%%%i%" (

        rem Deleta o arquivo ZIP
        echo Deletando arquivo %zip%
        del "%zip%"

      )

    ) else (

      rem Exibe mensagem para instalar o 7z ou extrair manualmente
      echo Instale 7z ou extraia o arquivo %zip% manualmente

    )

    rem Adiciona a pasta do ano ao .gitignore
    echo Adicionando %dados_enem%%%i%/ ao .gitignore
    grep -Fq "%dados_enem%%%i%/" .gitignore || echo "%dados_enem%%%i%/" >> .gitignore

  )

)

echo Dados do ENEM encontrados e prontos para uso
