FROM python:3.13
WORKDIR /app

RUN pip install uv

COPY pyproject.toml .
COPY .python-version .
COPY uv.lock .

RUN uv sync

COPY app.py .
COPY tr_shp tr_shp
COPY plot_turkey_map.py .

CMD [".venv/bin/flask","run","--debug","--host=0.0.0.0","--port=6003"]
