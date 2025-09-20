from flask import Flask, jsonify, request
import socket   # 👈 dodaj

app = Flask(__name__)

# sample database
tasks = [
    {"id": 1, "title": "Learn AWS", "done": False},
    {"id": 2, "title": "Build CI/CD pipeline", "done": False},
]

@app.route("/")
def index():
    hostname = socket.gethostname()
   
    return f"""
        <h1>🚀 Flask Todo App running on EC2!</h1>
        <p>Use /tasks to see the API.</p>
        <p><b>Instance:</b> {hostname}</p>
    """
@app.route("/tasks", methods=["GET"])
def get_tasks():
    return jsonify(tasks)

@app.route("/tasks", methods=["POST"])
def add_task():
    data = request.get_json()
    new_task = {
        "id": len(tasks) + 1,
        "title": data.get("title", "Untitled"),
        "done": False
    }
    tasks.append(new_task)
    return jsonify(new_task), 201

@app.route("/tasks/<int:task_id>", methods=["PUT"])
def update_task(task_id):
    for task in tasks:
        if task["id"] == task_id:
            task["done"] = True
            return jsonify(task)
    return jsonify({"error": "Task not found"}), 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
