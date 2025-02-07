FROM python:3.9-slim

# 安裝所需系統依賴
RUN apt-get update && apt-get install -y \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 複製應用程序文件
COPY requirements.txt .
COPY app.py .
COPY sql.json .
COPY SimHei.ttf .
COPY static/ ./static/
COPY templates/ ./templates/

# 安裝 Python 依賴
RUN pip install --no-cache-dir -r requirements.txt

# 創建 static/images 目錄
RUN mkdir -p static/images

# 設置環境變量
ENV FLASK_APP=app.py
ENV PYTHONUNBUFFERED=1

# 暴露端口
EXPOSE 8080

# 啟動命令
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]