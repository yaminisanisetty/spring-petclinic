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
 
   stage('Sonar scan execution') {
            // Run the sonar scan
           
                    //def mvnHome = tool 'mvn'
                    withSonarQubeEnv {

                        sh "'${mvnHome}/bin/mvn'  verify sonar:sonar -Dintegration-tests.skip=true -Dmaven.test.failure.ignore=true"
            }
        }
   //sonar
   stage('Build') {
      // Run the maven build
      withEnv(["MVN_HOME=$mvnHome"]) {
         if (isUnix()) {
            sh '"$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore clean package'
         } else {
            bat(/"%MVN_HOME%\bin\mvn" -Dmaven.test.failure.ignore clean package/)
         }
      }
   }
}
