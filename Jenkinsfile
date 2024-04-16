pipeline {
    agent any

    stages {
        // Previous stages remain unchanged

        stage('Connect to EC2') {
            steps {
                script {
                    // Define SSH credentials
                    def sshServer = [
                        credentialsId: 'SSH-KEY', // Use the ID of your SSH credentials
                        name: 'ec2-instance',
                        hostname: '35.180.190.54',
                        username: 'ubuntu'
                    ]

                    // Transfer files to EC2
                    sshPut remote: sshServer, from: '/home/yusei/Downloads/PPE-Auto-Ecole-main/*', into: '/home/ubuntu/PPE-Auto-Ecole-main/'

                    // Run commands on EC2
                    sshCommand remote: sshServer, command: 'cd /home/ubuntu/PPE-Auto-Ecole-main && docker-compose up --build -d', commandModifiers: '-o StrictHostKeyChecking=no'
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
