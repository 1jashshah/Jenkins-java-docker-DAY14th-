pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                // Checkout code from the specified Git repository
                git url: 'https://github.com/1jashshah/TF_WITH_JEN.git', branch: 'main'
            }
        }
        stage('Initialize Terraform') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }
        stage('Apply Terraform for All Workspaces') {
            steps {
                script {
                    def workspaces = ['dev', 'stage', 'prod']

                    // Loop through each workspace
                    for (workspace in workspaces) {
                        // Check if the workspace exists, create it if not
                        def checkWorkspace = sh(script: "terraform workspace list | grep ${workspace}", returnStatus: true)

                        if (checkWorkspace != 0) {
                            // Create the workspace if it doesn't exist
                            sh "terraform workspace new ${workspace}"
                        }

                        // Select the workspace
                        sh "terraform workspace select ${workspace}"

                        // Apply the configuration for the selected workspace
                        sh "terraform apply -var-file=${workspace}.tfvars -auto-approve"
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                // Optionally switch back to the default workspace
                sh 'terraform workspace select default'
            }
        }
    }
}
