from flask import Flask, render_template, request, send_file
import yt_dlp
import os
from pathlib import Path
import uuid

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        url = request.form["url"]
        tipo = request.form["tipo"]

        pasta = Path("downloads")
        pasta.mkdir(exist_ok=True)
        nome_arquivo = pasta / f"{uuid.uuid4()}.mp3" if tipo == "mp3" else pasta / f"{uuid.uuid4()}.mp4"

        ydl_opts = {
            "outtmpl": str(nome_arquivo),
            "quiet": True,
            "no_warnings": True,
        }

        if tipo == "mp3":
            ydl_opts.update({
                "format": "bestaudio/best",
                "postprocessors": [{
                    "key": "FFmpegExtractAudio",
                    "preferredcodec": "mp3",
                    "preferredquality": "192",
                }]
            })
        else:
            ydl_opts["format"] = "bestvideo+bestaudio/best"

        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            ydl.download([url])

        return send_file(nome_arquivo, as_attachment=True)

    return render_template("index.html")

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=port)
