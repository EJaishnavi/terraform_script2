pipeline {
    agent any

    environment {
        IMAGE_NAME = 'terraform-automation:latest'
        DOCKER_IMAGE = 'jaishnavi08/terraform-automation:latest'
       
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/EJaishnavi/terraform-script1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKER_IMAGE}
                        docker logout
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
