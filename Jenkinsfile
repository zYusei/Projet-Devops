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
        stage('Build and push Docker Image') {
            steps { 
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName:'docker') {
                        sh "docker build -t projet_devops ."
                        sh "docker tag projet_devops zyuseiii/projet_devops:latest"
                        sh "docker push zyuseiii/projet_devops:latest"
                    }
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
                // Add your test execution steps here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment steps here
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
