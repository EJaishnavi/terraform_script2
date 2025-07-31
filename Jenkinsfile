pipeline {
    agent any

    environment {
        IMAGE_NAME = 'terraform-automation:latest'
        DOCKER_IMAGE = 'jaishnavi08/terraform-automation:latest'
        AWS_ACCESS_KEY_ID     = credentials('access_key')      // Jenkins credential
        AWS_SECRET_ACCESS_KEY = credentials('secret_key')
    }

    stages {
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
  stage('Run Terraform in Docker') {
    steps {
        script {
            sh """
                docker pull ${DOCKER_IMAGE}
                docker run --rm \
                    -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
                    -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
                    -v \$(pwd):/app -w /app \
                    ${DOCKER_IMAGE}
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
