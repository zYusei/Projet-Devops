pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    docker.build("projet_devops:latest")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Démarrer les conteneurs Docker
                    docker.image("projet_devops:latest").withRun('-p 8081:80 --name projet_devops --link db:mysql') { c ->
                        // Attendre que le conteneur soit prêt
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'

            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                
            }
        }
    }
    post {
        always {
            // Nettoyer les ressources Docker
            cleanWs()
            sh 'docker stop projet_devops || true'
            sh 'docker rm projet_devops || true'
        }
    }
}
