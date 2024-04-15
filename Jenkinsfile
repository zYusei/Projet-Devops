pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                // Use the credentialsId you obtained while adding the credentials in Jenkins
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/zYusei/Projet-Devops.git'
            }
        }
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
                    sh 'docker-compose up --build -d'
                }
            }
        }
        stage('Run Tests') {
            steps {
                echo 'Running tests...'
                // Add your test execution steps here
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
            // Execute shell commands here
            sh 'docker-compose down'
        }
    }
}
