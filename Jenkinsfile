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
        stage('Run Docker Container') {
            steps {
                script {
                    // Start Docker database container
                    def dbContainer = docker.image('mysql:5.7').run('-e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=autoecole --name ppe-auto-ecole-main-db') 

                    // Start Docker web container linked to database container
                    docker.image("projet_devops:latest").run('-p 8081:80 --name ppe-auto-ecole-main-web --link ppe-auto-ecole-main-db:mysql') { c ->
                        // Wait until the container is ready
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add your test steps here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment steps here
            }
        }
        stage('Build Docker Compose') {
            steps {
                script {
                    // Change directory to where your docker-compose.yml file is located
                    dir('/home/yusei/Downloads/PPE-Auto-Ecole-main/') {
                        // Run docker compose up --build command
                        sh 'docker compose up --build'
                    }
                }
            }
        }
    }
    post {
        always {
            // Clean up Docker resources
            cleanWs()
            sh 'docker stop ppe-auto-ecole-main-web || true'
            sh 'docker rm ppe-auto-ecole-main-web || true'
            sh 'docker stop ppe-auto-ecole-main-db || true'
            sh 'docker rm ppe-auto-ecole-main-db || true'
        }
    }
}
