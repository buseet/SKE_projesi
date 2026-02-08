from flask import Flask, request, send_file
from plot_turkey_map import make_plot_from_json
from datetime import date
import flask_cors

app = Flask(__name__)
flask_cors.CORS(app)

@app.route("/", methods=["POST"])
def process_spreadsheet():
    data = request.get_json()
    
    today_str = date.today().strftime("%Y%m%d")
    output_name = f"iller_harita_subat_{today_str}.png"
    
    make_plot_from_json(data, output_name)
    
    return send_file(
        output_name,
        mimetype="image/png",
        as_attachment=True,
        download_name=output_name
    )
