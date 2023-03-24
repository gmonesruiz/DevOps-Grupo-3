pipeline{

	agent {label 'linux'}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jenkins-dockerhub')
	}

	stages {
	    
	    stage('gitclone') {

			steps {
				git 'https://github.com/GabrielMR1974/DevOps-Grupo-3.git'
			}
		}

		stage('Build') {

			steps {
				sh 'docker build -t Yeivt/grupo3-app:v1.0 ./DevOps-Grupo-3/Docker/Ejemplos/api-store'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push Yeivt/grupo3-app:v1.0'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}

