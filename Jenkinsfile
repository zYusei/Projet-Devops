pipeline {
    agent any
    environment {
        SSH_DEBUG = "true"
    }
    stages {
        stage('Example') {
            steps {
                sshagent(credentials: ['SSH-KEY']) {
                    sh 'ssh ubuntu@35.180.190.54 command'
                }
            }
        }
    }
}
