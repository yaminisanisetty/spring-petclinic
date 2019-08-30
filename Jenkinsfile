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
  
        sh "sudo docker build -t yaminisanisetty/petclinic:${version1} ."
        sh "sudo docker push yaminisanisetty/petclinic:${version1}"
    
} 
   stage('Pull and Run using docker compose '){
        
        sh "sudo docker-compose -f docker-compose1.yaml up -d --build"
   }
 
   stage('Run ansible playbook') {   
        //ansible-playbook -i pet-playbook.yaml -u devopsinfra --extra-vars {{version=$VERSION}}
        sh "sudo ansible-playbook annni/playbook.yaml -i /etc/ansible/hosts"
   }
  
  
    }


  


