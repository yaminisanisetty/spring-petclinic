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
   
   stage('Deploy approval'){
         input "Proceed with deployment?"  
   }
   
   stage('send notification') {
        mail to: 'devops531@gmail.com', from: 'devops531@gmail.com',
                  subject: "Build: ${env.JOB_NAME} - Success", 
                  body: "Job Failed - \"${env.JOB_NAME}\" build: ${env.BUILD_NUMBER}"
    }
   stage('Run ansible playbook') {   
        //ansible-playbook -i pet-playbook.yaml -u devopsinfra --extra-vars {{version=$VERSION}}
        sh "sudo ansible-playbook Pet-playbook.yaml -i /etc/ansible/hosts"
   }
  
  
    }


  


