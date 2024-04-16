pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                script {
                    sh '''
                        echo "Host *" > ~/.ssh/config
                        echo " StrictHostKeyChecking no" >> ~/.ssh/config
                    '''
                    sshagent(credentials: ['SSH-KEY']) {
                        sh 'ssh ubuntu@35.180.190.54 command'
                    }
                }
            }
        }
    }
}
