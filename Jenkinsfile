node {
    env.AWS_ECR_LOGIN=true
    def newApp
    def registry = 'docker-registry.cfapps.us10.hana.ondemand.com/test-cf'
    def registryCredential = 'dockerhub'
	
	stage('Git') {
		git 'https://github.com/chiptime/test-docker-compose-cloud-foundry'
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
    
    stage('Deploy to Cloud Foundry') {
        pushToCloudFoundry(
            target: 'https://api.cf.us10.hana.ondemand.com',
            organization: 'e9ae66datrial',
            cloudSpace: 'dev',
            credentialsId: 'cf-trial-patrick',
            manifestChoice: [manifestFile: 'path/to/manifest.yml']
        )
    }
    
}