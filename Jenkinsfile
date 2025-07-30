pipeline {
    agent any

    environment {
        IMAGE_NAME = 'terraform-automation:latest'  // Use your custom image name
        AWS_ACCESS_KEY_ID     = credentials('access-key')      // Secret Text ID in Jenkins
        AWS_SECRET_ACCESS_KEY = credentials('secret-key')  // Secret Text ID in Jenkins
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/EJaishnavi/terraform-script1.git'  // Replace with your repo
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Terraform in Docker') {
            steps {
                script {
                    sh """
                        docker run --rm \
                        -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
                        -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
                        -v \$(pwd):/app -w /app \
                        ${IMAGE_NAME}
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete.'
        }
    }
}
