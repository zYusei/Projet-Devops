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
                script {{
                        // Run docker compose up --build command
                        sh 'docker compose up --build'
                    }
                }
            }
        }
        // Add other stages as needed
    }
}
