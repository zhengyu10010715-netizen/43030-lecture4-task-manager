#!/bin/bash
set -euo pipefail

echo "Running task manager..."
python3 /app/.github/scripts/todo.py \
    | tee /tmp/todo_output.txt

echo "Running unit tests..."
python3 /app/.github/scripts/todo-test.py 2>&1 \
    | tee /tmp/test_output.txt

echo "Updating HTML report..."
bash /app/.github/scripts/update_index.sh \
    /tmp/todo_output.txt \
    /tmp/test_output.txt

echo "Process completed successfully."
