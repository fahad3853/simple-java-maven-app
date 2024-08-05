pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        DOCKER_IMAGE = 'fahadkhan3853/my-app:latest'
        K8S_NAMESPACE = 'default'
        K8S_DEPLOYMENT = 'my-app'
        GIT_REPO = 'https://github.com/fahad3853/simple-java-maven-app.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: "${GIT_REPO}", branch: 'master'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry(DOCKER_REGISTRY, 'dockerhub') {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'k8s-config', variable: 'KUBECONFIG')]) {
                        sh 'kubectl apply -f k8s-deployment.yaml'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
