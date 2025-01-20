# jenkinsScripts/pushChanges.sh
#!/bin/bash

EXECUTOR=$1
MOTIU=$2

git config --global user.email "lloalfsan@gmail.com"
git config --global user.name "alfosan"

git add README.md
git commit -m "Pipeline executada per ${EXECUTOR}. Motiu: ${MOTIU}"
git push origin HEAD:ci_jenkins