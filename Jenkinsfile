pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/zeeshankanuga/goapp.git'
        APP_NAME = 'go-web-app'
        AWS_REGION = 'ap-south-1'
        ECR_REPO = '825765397187.dkr.ecr.ap-south-1.amazonaws.com/goapp'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'go mod tidy'
                sh 'go build -o go-web-app'
                sh 'go test ./...'
            }
        }

        stage('Docker Build and Push to ECR') {
            steps {
                script {
                    sh """
                        aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO}
                        docker build -t ${APP_NAME}:${IMAGE_TAG} .
                        docker tag ${APP_NAME}:${IMAGE_TAG} ${ECR_REPO}:${IMAGE_TAG}
                        docker push ${ECR_REPO}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Update Helm Chart') {
            steps {
                withCredentials([string(credentialsId: 'Git', variable: 'GITHUB_PAT')]) {
                    script {
                        def chartPath = 'go-web-app-chart/values.yaml'
                        def githubRepo = 'https://github.com/zeeshankanuga/goapp.git'
                        def githubUsername = 'zeeshankanuga' // <-- replace with your actual GitHub username
        
                        sh """
                            sed -i 's|tag:.*|tag: "${IMAGE_TAG}"|' ${chartPath}
                            git config user.email "ci@jenkins.com"
                            git config user.name "Jenkins CI"
                            git add ${chartPath}
                            git commit -m "Update Helm chart image tag to ${IMAGE_TAG}"
        
                            git remote set-url origin https://${githubUsername}:${GITHUB_PAT}@github.com/zeeshankanuga/goapp.git
                            git push origin main
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
