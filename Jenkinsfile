pipeline {
    agent any
    parameters {
        string(name: 'Executor', defaultValue: 'Unknown', description: 'Nom de qui executa la pipeline')
        string(name: 'Motiu', defaultValue: 'Testing', description: 'Motiu de l\'execució')
        string(name: 'ChatID', defaultValue: '', description: 'Chat ID de Telegram')
    }
    environment {
        LINTER_STAGE = 'Failure'
        TEST_STAGE = 'Failure'
        UPDATE_README_STAGE = 'Failure'
        DEPLOY_STAGE = 'Failure'
    }
    stages {
        stage('Petició de dades') {
            steps {
                echo "Executor: ${params.Executor}"
                echo "Motiu: ${params.Motiu}"
                echo "ChatID: ${params.ChatID}"
            }
        }
        stage('Linter') {
            steps {
                sh 'npx eslint src/**/*.js || true'
            }
            post {
                success {
                    script {
                        env.LINTER_STAGE = 'Success'
                    }
                }
                failure {
                    script {
                        env.LINTER_STAGE = 'Failure'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                sh 'npx jest'
            }
            post {
                success {
                    script {
                        env.TEST_STAGE = 'Success'
                    }
                }
                failure {
                    script {
                        env.TEST_STAGE = 'Failure'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        stage('Update_Readme') {
            steps {
                script {
                    def badge = env.TEST_STAGE == 'Success' ? '![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)' : '![Failure](https://img.shields.io/badge/test-failure-red)'
                    sh "echo 'RESULTADO DE LOS ÚLTIMOS TESTS\n${badge}' >> README.md"
                }
            }
            post {
                success {
                    script {
                        env.UPDATE_README_STAGE = 'Success'
                    }
                }
                failure {
                    script {
                        env.UPDATE_README_STAGE = 'Failure'
                    }
                }
            }
        }
        stage('Push_Changes') {
            steps {
                sh '''
                    git config user.name "alfosan"
                    git config user.email "lloalfsan@gmail.com"
                    git add README.md
                    git commit -m "Pipeline executada per ${params.Executor}. Motiu: ${params.Motiu}"
                    git push origin main
                '''
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
                sh 'vercel --prod'
            }
            post {
                success {
                    script {
                        env.DEPLOY_STAGE = 'Success'
                    }
                }
                failure {
                    script {
                        env.DEPLOY_STAGE = 'Failure'
                    }
                }
            }
        }
        stage('Notificació') {
            steps {
                script {
                    def message = """S'ha executat la pipeline de jenkins amb els següents resultats:
                    - Linter_stage: ${env.LINTER_STAGE}
                    - Test_stage: ${env.TEST_STAGE}
                    - Update_readme_stage: ${env.UPDATE_README_STAGE}
                    - Deploy_to_Vercel_stage: ${env.DEPLOY_STAGE}"""
                    sh "curl -X POST https://api.telegram.org/bot7552715332:AAFiyqyO0xqf5ZpTIoeaNnIa1lqp0GRvWIA/sendMessage -d chat_id=${params.ChatID} -d text='${message}'"
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
