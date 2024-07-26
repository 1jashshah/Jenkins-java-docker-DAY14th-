pipeline {
    agent any
    environment {
        DOCKER_IMAGE = '1jashshah/day14th'
        DOCKERHUB_CREDENTIALS = credentials('env.dockerid')
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/1jashshah/Jenkins-java-docker-DAY13th-.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    sh "docker run -d --name my-container -p 8080:8080 ${DOCKER_IMAGE}:latest"
                }
            }
        }
    }
}
