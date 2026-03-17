from flask import Flask, render_template, jsonify
import psutil
import socket
import os
from datetime import datetime

app = Flask(__name__)
START_TIME = datetime.now()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/metrics')
def metrics():
    uptime = datetime.now() - START_TIME
    hours, remainder = divmod(int(uptime.total_seconds()), 3600)
    minutes, seconds = divmod(remainder, 60)

    return jsonify({
        'cpu':       round(psutil.cpu_percent(interval=1), 1),
        'memory':    round(psutil.virtual_memory().percent, 1),
        'disk':      round(psutil.disk_usage('/').percent, 1),
        'hostname':  socket.gethostname(),
        'ip':        socket.gethostbyname(socket.gethostname()),
        'namespace': os.getenv('POD_NAMESPACE', 'local'),
        'pod':       os.getenv('POD_NAME', socket.gethostname()),
        'version':   'v1.0.0',
        'uptime':    f'{hours}h {minutes}m {seconds}s'
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)