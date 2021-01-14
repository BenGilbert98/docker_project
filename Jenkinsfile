pipeline {
environment {
registry = "beng98/eng74_docker_project"
registryCredential = 'dockerhub_id'
dockerImage = ''
}
agent any
stages {
stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

checkout scm
}

stage('Building our image') {
steps{
script {
dockerImage = docker.build registry + ":$BUILD_NUMBER"
}
}
}
stage('Deploy our image') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push()
}
}
}
}
stage('Cleaning up') {
steps{
sh "docker rmi $registry:$BUILD_NUMBER"
}
}
}
}