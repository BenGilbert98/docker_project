pipeline {
environment {
registry = "beng98/eng74_docker_project"
registryCredential = 'dockerhub_id'
dockerImage = ''
}
agent any
stages {
stage('Cloning our Git') {
steps {
git 'https://github.com/BenGilbert98/docker_project.git'
}
}

stage('Clone repository') {
/* Let's make sure we have the repository cloned to our workspace */
steps{
script {
    checkout scm
}
}
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