pipeline {
    agent any

    environment {
        IMAGE_NAME = 'terraform-automation:latest'  // Use your custom image name
        AWS_ACCESS_KEY_ID     = credentials('access_key')      // Secret Text ID in Jenkins
        AWS_SECRET_ACCESS_KEY = credentials('secret_key')  // Secret Text ID in Jenkins
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
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'terraform-deployer:latest'
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')      // Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')  // Jenkins credentials ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Terraform Apply in Container') {
            steps {
                script {
                    docker.image("${IMAGE_NAME}").inside("-e AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}") {
                        sh 'chmod +x entrypoint.sh'
                        sh './entrypoint.sh'
                    }
                }
            }
        }
    }

    post {
        failure {
            echo 'Terraform apply failed!'
        }
        success {
            echo 'Terraform apply completed successfully.'
        }
    }
}
