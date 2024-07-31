pipeline {
    agent any

    environment {
        registry = 'docker.io'  
        registryCredential = 'dockerid' 
    }

    stages {
        stage ('Checkout') {
            steps {
                git url: 'https://github.com/1jashshah/Jenkins-java-docker-DAY14th-.git', credentialsId: 'gitid', branch: 'main'
            }
        }

        stage ('Docker Build') {
            steps {
                script {
                    docker.withRegistry('', registryCredential){
                        def customImage = docker.build("1jashshah/myjava-app:${env.BUILD_ID}")
                        customImage.push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {

                script {
                    docker.withRegistry('', registryCredential) {
                        def runContainer = docker.image("1jashshah/myjava-app:${env.BUILD_ID}").run('--name mynew-container -d')
                        echo "Container ID: ${runContainer.id}"
                    }
                }
            }
        }

        stage('Output') {
            steps{
                script{
                    sh 'javac App.java'
                    sh 'java App.java'
                }
            }
        }


    }
    post {
        always {
            echo 'Pipeline Finished'
        }
        success {
            echo 'Status : Successfull'
        }
        failure {
            echo 'Status : Failed'
        }
    }
}
