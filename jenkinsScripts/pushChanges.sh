#!/bin/bash
git add README.md
git commit -m "Pipeline executada per $1. Motiu: $2"
git push origin main