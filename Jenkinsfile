pipeline {
    agent any
    environment {
        scannerHome = tool name: 'sonar-scanner'
        SONAR_TOKEN = credentials('jenkins-sonar')
    }
    stages {
        stage('Obtener el proyecto') {
            steps {
                git branch: 'main', poll: false, url: 'https://github.com/EnriqueTun23/1640-LOCAL-ORDER-ADMI.git'
            }
        }
        stage('Entrar ala carpeta cobol') {
            steps {
                script {
                    echo 'Entrando ala carpeta cobol para scannear'
                    sh 'cd ./Codigo/Cobol'
                }
            }
        }
        stage('Scanner cobol') {
            steps {
                withSonarQubeEnv('sc1') {
                    sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.login=${SONAR_TOKEN} \
                        -X
                    """
                }
            }
        }
        stage('Regresar ala carpeta principal') {
            steps {
                script {
                    echo 'Regresar ala carpeta principal y entrar a c++'
                    sh 'cd ../..'
                    sh 'cd ./Codigo/C++'
                }
            }
        }
        stage('Escanear codigo c++') {
            steps {
                script {
                    sh 'build-wrapper-linux-x86-64 --out-dir bw-output ./compile.sh'
                }
            }
        }
        
    }
}