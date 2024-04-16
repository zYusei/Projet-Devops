pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                script {
                    sh '''
                        echo "Host *" > ~/.ssh/ssh_config
                        echo " StrictHostKeyChecking no" >> ~/.ssh/ssh_config
                    '''
                    sshagent(credentials: ['SSH-KEY']) {
                        sh 'ssh ubuntu@35.180.190.54 command'
                    }
                }
            }
        }
    }
}
