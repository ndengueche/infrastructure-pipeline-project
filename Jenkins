def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]

pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'clonin project from repo'
                git branch: 'main', url: 'https://github.com/ndengueche/infrastructure-pipeline-project.git'
                sh 'ls'
            }
        }
        
        stage('Verify terraform version') {
            steps {
                echo 'Verifying terraform version...'
                sh 'terraform --version'
            }
        }
        
        
        stage('Terraform init') {
            steps {
                echo 'Initializing terraform project...'
                sh 'terraform init'
            }
        }
        
        stage('Terraform validate') {
            steps {
                echo 'Code syntax checking...'
                sh 'terraform validate'
            }
        }
        
        stage('Terraform plan') {
            steps {
                echo 'Terraform plan for the dry run...'
                sh 'terraform plan'
            }
        }
        
        stage('Checkov scan') {
            steps {
                sh """
                sudo pip3 install checkov
            
                checkov -d . --skip-check CKV_AWS_79,CKV2_AWS_41
            
                """
            }
        }
        
        stage('Manual approval') {
            steps {
                input 'Approval required for deployment'
            }
        }
        
        stage('Terraform apply') {
            steps {
                echo 'Creating infrastructure...'
                sh 'sudo terraform apply --auto-approve'
            }
        }
    }
    
    post {
        always {
            echo 'Slack Notifications.'
            slackSend channel: '#my-notification-channel', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    } 
    
}
