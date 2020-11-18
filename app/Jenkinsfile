///

pipeline {

    agent any
    
    stages { 
      stage('build') {
        steps{
          script{
            if (env.BRANCH_NAME == 'master') {
              image = "1.0.${BUILD_NUMBER}"
            } else if (env.BRANCH_NAME == 'dev') {
              image = "dev-$GIT_COMMIT"
            } else if (env.BRANCH_NAME == 'staging') {
              image = "staging-$GIT_COMMIT"
            } else {
              image = "unknown"
            }
            sh "docker build -t natalicot/echo-app:${image} ."
          }
        }
      }
      stage('deploy') {
        steps{
          script{
            withCredentials([[$class: 'UsernamePasswordMultiBinding',credentialsId: 'docker_hub',usernameVariable: 'USER',passwordVariable: 'PASSWORD']]){
              sh "docker login -u $USER -p $PASSWORD"
              sh "docker push natalicot/echo-app:${image}"
            }
          }
        }
      }
    }

}
//
