# jenkinsScripts/updateReadme.sh
#!/bin/bash

# Check if tests passed
if [ "$TEST_STAGE" = "Success" ]; then
    BADGE="![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)"
else
    BADGE="![Failure](https://img.shields.io/badge/test-failure-red)"
fi

# Add or update badge in README
if grep -q "RESULTADO DE LOS ÚLTIMOS TESTS" README.md; then
    sed -i "/RESULTADO DE LOS ÚLTIMOS TESTS/!b;n;c${BADGE}" README.md
else
    echo -e "\n## RESULTADO DE LOS ÚLTIMOS TESTS\n${BADGE}" >> README.md
fi