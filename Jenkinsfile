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
    
   
    stage('Build') {
        sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"    
    }
    
  
    }


  


