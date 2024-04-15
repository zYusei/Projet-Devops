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
                    // Build and push Docker image with the correct name
                    docker.withRegistry('https://index.docker.io/v1/', '2f413927-dcc6-4201-9a21-521075172e4d') {
                        def customImage = docker.build("zYuseiii/projet-devops:latest")
                        customImage.push()
                    }
                }
            }
        }
        stage('Run Docker Containers') {
            steps {docker push zyuseiii/projet_devops:tagname
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
