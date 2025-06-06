@echo off
title Deploy MpTudo Automático

REM Caminho da pasta do projeto
cd /d "%~dp0"

echo.
echo === ORGANIZANDO PASTAS ===
mkdir templates 2>nul

echo.
echo === CRIANDO app.py ===
(
echo from flask import Flask, render_template, request
echo from pathlib import Path
echo import yt_dlp
echo import threading
echo.
echo app = Flask(__name__)
echo.
echo @app.route('/', methods=['GET', 'POST'])
echo def index():
echo     if request.method == 'POST':
echo         url = request.form.get('url')
echo         tipo = request.form.get('tipo')
echo         pasta = str(Path.home() / "Downloads")
echo         ydl_opts = {
echo             'outtmpl': f"%%s/%%(title)s.%%(ext)s" %% pasta,
echo             'quiet': True,
echo             'no_warnings': True
echo         }
echo         if tipo == 'mp3':
echo             ydl_opts.update({
echo                 'format': 'bestaudio/best',
echo                 'postprocessors': [{
echo                     'key': 'FFmpegExtractAudio',
echo                     'preferredcodec': 'mp3',
echo                     'preferredquality': '192',
echo                 }]
echo             })
echo         else:
echo             ydl_opts['format'] = 'bestvideo+bestaudio/best'
echo         def baixar():
echo             with yt_dlp.YoutubeDL(ydl_opts) as ydl:
echo                 ydl.download([url])
echo         threading.Thread(target=baixar).start()
echo         return "Download iniciado com sucesso!"
echo     return render_template("index.html")
echo.
echo if __name__ == '__main__':
echo     app.run()
) > app.py

echo.
echo === CRIANDO requirements.txt ===
(
echo flask
echo yt_dlp
) > requirements.txt

echo.
echo === CRIANDO templates/index.html ===
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>^<title^>MpTudo^</title^>^</head^>
echo ^<body style="text-align: center;"^>
echo ^<h2^>Cole o link do vídeo aqui^</h2^>
echo ^<form method="POST"^>
echo     ^<input name="url" type="text" placeholder="URL do vídeo" style="width: 300px;"^>
echo     ^<br^>^<br^>
echo     ^<label^>^<input type="radio" name="tipo" value="mp3" checked^> MP3^</label^>
echo     ^<label^>^<input type="radio" name="tipo" value="video"^> Vídeo^</label^>
echo     ^<br^>^<br^>
echo     ^<button type="submit"^>Baixar^</button^>
echo ^</form^>
echo ^</body^>
echo ^</html^>
) > templates\index.html

echo.
echo === FAZENDO DEPLOY PRO GITHUB ===
git init
git branch -M main
git remote remove origin 2>nul
git remote add origin https://github.com/STAVARENG0/MpTudo-Web.git
git add .
git commit -m "Deploy automático do MpTudo Web"
git push -u origin main

echo.
echo === FINALIZADO COM SUCESSO ===
pause
