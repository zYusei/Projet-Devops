pipeline {
    agent any

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/zYusei/Projet-Devops.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
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
                    sh 'docker-compose up --build -d'
                }
            }
        }
        stage('Run Tests') {
            steps {
                echo 'Running tests...'
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    def ec2Instance = [
                        name: 'ec2-instance',
                        host: '35.180.190.54',
                        user: 'ubuntu',
                        credentialsId: 'SSH-KEY' // ID of SSH credentials
                    ]

                    // Execute commands on the EC2 instance
                    sshagent(credentials: ['SSH-KEY']) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@35.180.190.54 'cd /home/ubuntu/PPE-Auto-Ecole-Main && sudo docker-compose up --build -d'
                        '''
                    }
                }
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
