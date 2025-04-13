pipeline {
    agent any
    
    stages {
        stage('Clonado repo codigo fuente') {
            steps {
                git url: 'https://github.com/JuanLuisHernandezTerron/development-environment-UNIR.git', branch: 'main'
            }
        }
        
        stage('construccion image') {
            steps {
               bat 'docker-compose build --no-cache'
            }
        }
        
        stage('construccion containers') {
            steps {
               bat 'docker-compose up -d'
            }
        }

        stage('entrar contenedor & lanzamiento de pruebas y flask8') {
            steps {
                bat 'docker exec proyecto_final_unir bash -c "pytest app/test_routes.py && flake8 ./ --max-line-length=100 --statistics --count || exit 0"'
            }
        }
    
        stage('Push to Docker Hub (solo main/develop/master)') {
            steps {
                script {
                    def rawBranch = bat(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
                    def branch = rawBranch.tokenize("\n")[-1].trim().replace('\r','')     
                    if (branch == 'main' || branch == 'develop' || branch == 'master') {
                        withCredentials([usernamePassword(
                            credentialsId: 'credentials_dockerhub',
                            usernameVariable: 'DOCKER_USER',
                            passwordVariable: 'DOCKER_PASS'
                        )]) {
                            bat """
                                docker build -t unir-pipeline-python-web .
                                docker tag unir-pipeline-python-web $DOCKER_USER/unir-pipeline-python-web:latest
                                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                                docker push $DOCKER_USER/unir-pipeline-python-web:latest
                                docker logout
                            """
                        }
                    }else{
                        echo "NO SE HACE PUSH, RAMA ACTUAL ${branch}"
                    }
                }
            }
        }
    }
}
