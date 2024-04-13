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
                    dir('/home/yusei/Downloads/PPE-Auto-Ecole-main/') {
                        // Run docker compose up --build command
                        sh 'docker-compose up --build -d'
                    }
                }
            }
        }
        // Add other stages as needed
    }
    post {
        always {
            // Clean up Docker resources
            cleanWs()
            sh 'docker-compose down'
        }
    }
}
