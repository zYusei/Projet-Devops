pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                sshagent(credentials: ['SSH-KEY']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@35.180.190.54 command'
                }
            }
        }
    }
}
