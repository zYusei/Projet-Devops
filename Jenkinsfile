pipeline {
    agent any
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
