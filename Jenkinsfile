pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps { 
                script {
                    // Build Docker image with the correct name
                    docker.build("projet_devops:latest")
                }
            }
        }
        stage('Run Docker Containers') {
            steps {
                script {
                    // Run docker compose up --build command
                    sh 'docker compose up --build -d'
                }
            }
        }
        stage('Run Tests') {
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
        success {
            echo 'Pipeline completed successfully!'

        }
        failure {
            echo 'Pipeline failed!'

        }
        always {

            sh 'docker-compose down'
        }
    }
}
