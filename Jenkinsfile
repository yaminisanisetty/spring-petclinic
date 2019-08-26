node {
try{
   def mvnHome
   def server =Artifactory.server 'artifactory'
   stage('Preparation') {
      git 'https://github.com/yaminisanisetty/spring-petclinic.git' 
      mvnHome = tool 'MAVEN'
   }
    stage('Quality Analysis') {
        withSonarQubeEnv('sonarqube') {
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
    
    stage('Results') {
     junit '*target/surefire-reports/TEST-*.xml'
      archive 'target/*.war'
    }
   
    stage('Artifactory upload') { 
        def uploadSpec = """ 
        {  
		"files": [ { "pattern": "/var/lib/jenkins/workspace/StageOne/target/*.war", "target": "car-info" } ]  
        }"""  
        server.upload(uploadSpec) 
    } 
    }
    catch(err){
        stage('MAIL'){
        
        mail bcc: '', body: 'Build Failed', cc: '', from: '', replyTo: '', subject: 'Build Failed', to: 'lakshmiyamini.sanisetty@mindtree.com'
        
        
    }
    }
}
  


