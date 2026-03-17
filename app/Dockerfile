# ── Base image ────────────────────────────────────────
# Python slim reduce el tamaño de la imagen considerablemente
# 3.11 en lugar de 3.14 por estabilidad en producción
FROM python:3.11-slim

# ── Metadata ──────────────────────────────────────────
LABEL maintainer="Carlos Amador Lopez"
LABEL version="1.0.0"
LABEL description="Cloud-AKS Platform - Infrastructure Monitoring Dashboard"

# ── Variables de entorno ──────────────────────────────
ENV PYTHONDONTWRITEBYTECODE=1  
ENV PYTHONUNBUFFERED=1         
ENV FLASK_ENV=production

# ── Directorio de trabajo ─────────────────────────────
WORKDIR /app

# ── Dependencias ──────────────────────────────────────
# Copiamos requirements ANTES del código
# Así Docker cachea esta capa y no reinstala si solo cambia el código
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ── Código de la aplicación ───────────────────────────
COPY . .

# ── Usuario no root — Security best practice ──────────
# Nunca correr contenedores como root en producción
RUN adduser --disabled-password --gecos '' appuser
USER appuser

# ── Puerto expuesto ───────────────────────────────────
EXPOSE 5000

# ── Health check ──────────────────────────────────────
# Kubernetes usa esto para saber si el pod está sano
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/api/metrics')"

# ── Comando de inicio ─────────────────────────────────
CMD ["python", "app.py"]