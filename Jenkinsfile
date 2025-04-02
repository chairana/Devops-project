pipeline {
    agent {
        docker {
            image 'jenkins-aws-agent'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        ECR_REPO = '767397922470.dkr.ecr.us-east-1.amazonaws.com/nodejs-devops'
        IMAGE_TAG = "node-api-${BUILD_NUMBER}"
        AWS_REGION = 'us-east-1'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/chairana/Devops-project.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO:$IMAGE_TAG .'
            }
        }
        stage('Push to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    sh '''
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                        docker push $ECR_REPO:$IMAGE_TAG
                    '''
                }
            }
        }
    }
}