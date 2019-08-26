node {

   def mvnHome
   //def server =Artifactory.server 'artifactory'
   stage('Preparation') {
      git 'https://github.com/yaminisanisetty/spring-petclinic.git' 
      mvnHome = tool 'MAVEN'
   }
    stage('Quality Analysis') {
        withSonarQubeEnv('sonar') {
        sh 'mvn clean package sonar:sonar'
        }
    }
    
    stage("Quality Gate"){
        timeout(time: 1, unit: 'HOURS') { 
            def qg = waitForQualityGate() 
            if (qg.status != 'OK') {
                currentBuild.status='FAILURE'
                error "Pipeline aborted due to quality gate failure: ${qg.status}"
            }
        }
    }
   
    stage('Build') {
        sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"    
    }
    
  
    }


  


