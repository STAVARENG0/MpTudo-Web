@echo off
cd /d "%~dp0"

:: Apaga histórico git antigo, se existir
rmdir /s /q .git

:: Inicia novo repositório Git
git init

:: Configura identidade
git config user.name "STAVARENG0"
git config user.email "services.go.viral@gmail.com"

:: Adiciona todos os arquivos
git add .

:: Cria commit
git commit -m "🚀 Substituição completa do projeto MpTudo Web"

:: Conecta ao repositório do GitHub
git remote add origin https://github.com/STAVARENG0/MpTudo-Web.git

:: 🔥 Define o branch atual como main
git branch -M main

:: Força push para substituir tudo no GitHub
git push -f origin main

echo.
echo ================================
echo ✅ Código enviado com sucesso!
echo 🌐 Acesse: https://github.com/STAVARENG0/MpTudo-Web
echo ================================
pause
