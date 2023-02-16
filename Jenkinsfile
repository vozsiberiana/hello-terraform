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
        stage("Deployment"){
            steps {
                sh 'cd ansible/'
                sshagent(['ssh-amazon']){
                    withAWS(credentials: 'aws-credentials', region: 'eu-west-1')  {
                       sh 'ansible-playbook -i aws_ec2.yml ec2.yml'
                    }
                }
            }
        }
    }
}
