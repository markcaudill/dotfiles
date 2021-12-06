/* Requires the Docker Pipeline plugin */
node('docker') {
    checkout scm
    stage('Build') {
        docker.image('ubuntu:latest').inside {
            sh 'apt-get -y install git make shellcheck'
			sh 'make shellcheck'
        }
    }
}
