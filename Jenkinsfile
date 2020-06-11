node {
    env.AWS_ECR_LOGIN=true
    def newApp
    def registry = '$CF_REGISTRY_URL/$CF_APP_NAME'
    def registryCredential = 'dockerhub'

	stage('Git') {
		git '$GIT_URL'
	}
	stage('Building image') {
        docker.withRegistry( 'https://' + registry, '' ) {
		    def buildName = registry + ":$BUILD_NUMBER"
			newApp = docker.build buildName
        }
	}
	stage('Registring image') {
        docker.withRegistry( 'https://' + registry, '' ) {
    		newApp.push 'latest'
        }
	}
    stage('Removing image') {
        sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $registry:latest"
    }
    
    stage ('Deploy to Cloud Foundry') {
        sh 'pwd'
        sh 'cf login -a $CF_API_ENDPOINT -u $CF_CREDENTIALS_USER -p $CF_CREDENTIALS_PASSWORD'
        sh 'cf push'
    }
}