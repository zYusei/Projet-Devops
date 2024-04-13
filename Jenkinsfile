pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "monsitecrypto:${env.BUILD_ID}"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    docker.build(env.DOCKER_IMAGE)
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
}