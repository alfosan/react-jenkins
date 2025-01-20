#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Faltan parámetros para el commit."
    exit 1
fi

git config user.name "$1"
git config user.email "lloalfsan@gmail.com"
git add README.md
git commit -m "Pipeline executada per $1. Motiu: $2"
git push origin main || {
    echo "Error en el push. Haciendo pull con rebase..."
    git pull --rebase origin main
    git push origin main
}
