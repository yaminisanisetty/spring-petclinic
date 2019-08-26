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
    
   stage('Build and Push Spring Petclinic Docker Image') {
        // "sudo cp $WORKSPACE/target/*.jar $WORKSPACE/spring-petclinic.jar"
        sh "sudo docker build -t yaminisanisetty/Petclinic:$VERSION ."
        sh "sudo docker push yaminisanisetty/Petclinic:$VERSION"
    
}
  
    }


  


