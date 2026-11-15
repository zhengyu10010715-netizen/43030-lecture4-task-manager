# Task Manager

A Python task manager with automated unit testing and an HTML report.

## Requirements

- Python 3 for running the application and tests locally.
- Docker for running the complete reporting pipeline.

## Run the task manager

From the repository root, run:

```bash
python3 .github/scripts/todo.py
```

The program displays sample tasks grouped into ToDo and Done.

## Run the unit tests

From the repository root, run:

```bash
python3 .github/scripts/todo-test.py
```

The three tests check task addition, ToDo task filtering, and Done task filtering.
The test script returns a non-zero exit code if a test fails.

On Windows, use `python` instead of `python3` if that is the command for your Python 3 installation.

## Automated HTML report

A push to main triggers the Task Manager CI workflow.

The workflow builds a Docker image and starts a container.
The entrypoint script runs the task manager and unit tests, then updates
index.html with the task lists and test results.

If these steps succeed, the workflow commits any changes to index.html
back to main.
