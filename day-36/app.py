from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from My Cloud Journey! (Day 88 CI/CD Automated EKS Deployment)"

@app.route("/health")
def health():
    return jsonify({"status": "healthy", "service": "my-cloud-journey"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
