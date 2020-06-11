pipeline {
  agent any
    
  enviroment {
    registry = 'docker-registry.cfapps.us10.hana.ondemand.com/test-cf'
    dockerImage = ''
  }

  stages {      
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registryName + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}