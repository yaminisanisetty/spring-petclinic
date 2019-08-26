node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
       git 'https://github.com/yaminisanisetty/spring-petclinic.git' 
      // Get the Maven tool.
      // ** NOTE: This 'mvn' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'Maven'
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
    catch(err) {
        stage('MAIL') {
        
        mail bcc: '', body: 'Build Failed', cc: '', from: '', replyTo: '', subject: 'Build Failed', to: 'yaminisanisetty@gmail.com' 
        
    }
    }
}
