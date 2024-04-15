def ec2Instance = [ 
    credentialsId: 'aws',
    remote: [
        name: 'ec2-instance',
        host: '35.180.192.24',
        user: 'ubuntu',
        allowAnyHosts: true
    ]
]

pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('aws')
    }

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
        stage('Deploy to EC2') {
            steps {
                // SSH into EC2 instance using AWS credentials
                script {
                    sshCommand remote: ec2Instance, credentialsId: 'aws', command: '''
                        # Copy project files to EC2 instance
                        scp -r /home/yusei/Downloads/Projet-Devops ubuntu@ec2-instance:/home/ubuntu

                        # Execute deployment script on EC2 instance
                        ssh ubuntu@ec2-instance 'cd /home/yusei/Downloads/Projet-Devops && docker-compose up --build'
                    '''
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
