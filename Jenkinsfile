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
                // Add your test execution steps here
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    sshCommand remote: ec2Instance, credentialsId: 'aws', command: '''
                        scp -r /home/yusei/Downloads/PPE-Auto-Ecole-main ubuntu@ec2-instance:/home/ubuntu
                        ssh ubuntu@ec2-instance 'cd /home/yusei/Downloads/PPE-Auto-Ecole-main && docker-compose up --build'
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
