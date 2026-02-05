from flask import Flask, render_template, request, send_file
from plot_turkey_map import make_plot_from_file
from datetime import date

app = Flask(__name__)

@app.route("/", methods=["GET"])
def render_root():
    return render_template("index.html")

@app.route("/", methods=["POST"])
def process_spreadsheet():
    file = request.files["file"]
    
    today_str = date.today().strftime("%Y%m%d")
    output_name = f"iller_harita_subat_{today_str}.png"
    
    make_plot_from_file(file, output_name)
    return send_file(
        output_name,
        mimetype="image/png",
        as_attachment=True,
        download_name=output_name
    )
