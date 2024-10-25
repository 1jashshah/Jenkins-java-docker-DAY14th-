pipeline {
    agent any
    environment {
        TF_WORKSPACE = ''
    }
    stages {
        stage('git-checkout'){
            steps{
                git url: 'https://github.com/1jashshah/TF_WITH_JEN.git', branch: 'main'
            }
        }
        stage('Initialize Terraform') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Apply Terraform for All Workspaces') {
            steps {
                script {
                    def workspaces = ['dev', 'ops', 'stage', 'prod']
                    
                    for (workspace in workspaces) {
                        // Try to select the workspace, create if it doesn't exist
                        def workspaceSelectCmd = "terraform workspace new ${workspace} || terraform workspace select ${workspace} "
                        sh workspaceSelectCmd
                        
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
                sh 'terraform workspace select default'
            }
        }
    }
}
