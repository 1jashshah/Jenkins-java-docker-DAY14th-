pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('env.dockerid')
        DOCKERHUB_REPO = '1jashshah/day14th'
        GIT_REPO = 'https://github.com/1jashshah/Jenkins-java-docker-DAY13th-.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: "${env.GIT_REPO}", branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${env.DOCKERHUB_REPO}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', "${env.DOCKERHUB_CREDENTIALS}") {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    dockerImage.run('-d -p 8080:8080')
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
