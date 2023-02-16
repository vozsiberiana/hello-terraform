pipeline {
    agent any

    stages {
        stage("Terraform"){
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-west-1') {
                    sh 'terraform init'
		    sh 'terraform fmt'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
