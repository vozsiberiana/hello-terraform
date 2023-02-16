pipeline {
    agent any

    options {
        timestamps()
        ansiColor('xterm')
    }


    stages {

        stage('Build') {
            steps {
                sh 'docker-compose build'
		sh 'git tag 1.0.${BUILD_NUMBER}'
		sh 'docker tag ghcr.io/vozsiberiana/hello-2048/hello-2048:v1 ghcr.io/vozsiberiana/hello-2048/hello-2048:1.0.${BUILD_NUMBER}'
            }
	}

        stage('Package') {	
            steps {
		withCredentials([string(credentialsId: 'github-vozsiberiana', variable: 'GIT_TOKEN')]) {
		    sh 'echo $GIT_TOKEN | docker login ghcr.io -u vozsiberiana --password-stdin'
                    sh 'docker push ghcr.io/vozsiberiana/hello-2048/hello-2048:1.0.${BUILD_NUMBER}'
		 }
            }
        }
        

	stage("Terraform") {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-west-1') {
                    sh 'terraform init'
		    sh 'terraform fmt'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        
	stage("Deployment") {
            steps {
                sshagent(['ssh-amazon']) {
                    withAWS(credentials: 'aws-credentials', region: 'eu-west-1')  {
                      ansiblePlaybook(
			credentialsId: 'aws-credentials',
			inventory: '/home/sinensia/hello-terraform/ansible/aws_ec2.yml',
			playbook: '/home/sinensia/hello-terraform/ansible/hello-2048.yml'
		      )

                    }
                }
            }
        }
    }
}
