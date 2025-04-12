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
               bat 'docker-compose up'
            }
        }
        
        stage('ejecucion test') {
            steps {
               bat 'docker exec -it proyecto_final_unir pytest /app/test_routes.py'
            }
        }
        
        stage('Lanzamiento de flask8') {
            steps {
               bat 'flake8 reto_final_python_unir/ --max-line-length=100 --statistics --count'
            }
        }
    
        stage('Push to Docker Hub (solo main/develop/master)') {
            steps {
                script {
                    def branch = bat(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
                    if (branch == 'main' || branch == 'develop' || branch == 'master') {
                        withCredentials([usernamePassword(
                            credentialsId: 'crendetials docker hub',
                            usernameVariable: 'DOCKER_USER',
                            passwordVariable: 'DOCKER_PASS'
                        )]) {
                            bat """
                                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                                docker tag proyecto_final_unir $IMAGE_NAME:$branch
                                docker push $IMAGE_NAME:$branch
                                docker logout
                            """
                        }
                    }
                }
            }
        }
    }
}
