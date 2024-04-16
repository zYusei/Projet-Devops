pipeline {
    agent any

    stages {
        stage('Connect to EC2') {
            steps {
                script {
                    def sshServer = [
                        name: 'ec2-instance',
                        host: '35.180.190.54',
                        user: 'ubuntu',
                        credentialsId: 'SSH-KEY', // Use the ID of your SSH credentials
                        allowAnyHosts: true // Set allowAnyHosts to true
                    ]

                    sshagent(credentials: ['SSH-KEY']) {
                        // Execute commands on the EC2 instance
                        sshCommand remote: sshServer, command: 'ls -l /home/ubuntu'
                    }
                }
            }
        }
    }
}
