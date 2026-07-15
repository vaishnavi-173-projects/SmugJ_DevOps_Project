from flask import Flask, jsonify
import os
import logging

# Set up corporate-grade production logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

# Read configurations dynamically from the environment
ENVIRONMENT = os.getenv("APP_ENV", "Production")
PORT = int(os.getenv("APP_PORT", 5000))

# Kubernetes Health Check Endpoint (Essential for AKS clusters)
@app.route('/healthz', methods=['GET'])
def health_check():
    logger.info("AKS cluster health probe received.")
    return jsonify({
        "status": "healthy",
        "service": "user-management-api"
    }), 200

# Real-time API Endpoint
@app.route('/api/v1/status', methods=['GET'])
def get_status():
    logger.info("API status requested by user.")
    return jsonify({
        "status": "success",
        "data": {
            "message": "Application is responding successfully!",
            "environment": ENVIRONMENT,
            "cloud_provider": "Azure AKS"
        }
    }), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT)