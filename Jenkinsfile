pipeline {
    agent any
    environment {
        REACT_APP_VERCEL_ANALYTICS_ID = credentials('VERCEL_ANALYTICS_ID')
        GMAIL_USER = credentials('GMAIL_USER')
        GMAIL_PASS = credentials('GMAIL_PASS')
        METRICS_TOKEN = credentials('METRICS_TOKEN')
        VERCEL_TOKEN = credentials('VERCEL_TOKEN')
        ORG_ID = credentials('ORG_ID')
        PROJECT_ID = credentials('PROJECT_ID')
        PAT_TOKEN = credentials('PAT_TOKEN')
        TELEGRAM_TOKEN = credentials('TELEGRAM_TOKEN')
        TELEGRAM_CHAT_ID = credentials('TELEGRAM_CHAT_ID')
    }
    parameters {
        string(name: 'Executor', defaultValue: 'Unknown', description: 'Nom de qui executa la pipeline')
        string(name: 'Motiu', defaultValue: 'Testing', description: 'Motiu de l\'execució')
    }
    stages {
        stage('Petició de dades') {
            steps {
                echo "Executor: ${params.Executor}"
                echo "Motiu: ${params.Motiu}"
                echo "ChatID: ${TELEGRAM_CHAT_ID}"
            }
        }
        stage('Linter') {
            steps {
                echo "Running Linter..."
                sh 'npx eslint src/**/*.js || true'
            }
        }
        stage('Test') {
            steps {
                echo "Running Tests..."
                sh 'npx jest'
            }
        }
        stage('Build') {
            steps {
                echo "Building project..."
                sh 'npm run build'
            }
        }
        stage('Update_Readme') {
            steps {
                echo "Updating README with test results..."
                script {
                    def badge = env.TEST_STAGE == 'Success' ? '![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)' : '![Failure](https://img.shields.io/badge/test-failure-red)'
                    writeFile file: 'README.md', text: "## RESULTADO DE LOS ÚLTIMOS TESTS\n\n${badge}"
                }
            }
        }
        stage('Push Changes') {
            steps {
                echo "Pushing changes to GitHub..."
                sh './jenkinsScripts/pushChanges.sh "${params.Executor}" "${params.Motiu}"'
            }
        }
        stage('Deploy to Vercel') {
            when {
                allOf {
                    environment name: 'LINTER_STAGE', value: 'Success'
                    environment name: 'TEST_STAGE', value: 'Success'
                    environment name: 'UPDATE_README_STAGE', value: 'Success'
                }
            }
            steps {
                echo "Deploying to Vercel..."
                sh './jenkinsScripts/deployToVercel.sh'
            }
        }
        stage('Notificació') {
            steps {
                echo "Sending notification to Telegram..."
                script {
                    def message = """
                    S'ha executat la pipeline de Jenkins amb els següents resultats:
                    - Linter_stage: ${env.LINTER_STAGE ?: 'Unknown'}
                    - Test_stage: ${env.TEST_STAGE ?: 'Unknown'}
                    - Update_readme_stage: ${env.UPDATE_README_STAGE ?: 'Unknown'}
                    - Deploy_to_Vercel_stage: ${env.DEPLOY_STAGE ?: 'Unknown'}
                    """
                    sh """
                        curl -X POST https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage -d chat_id=${TELEGRAM_CHAT_ID} -d text="${message}"
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline finalitzada. Revisa els resultats!'
        }
    }
}
