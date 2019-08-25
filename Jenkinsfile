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
