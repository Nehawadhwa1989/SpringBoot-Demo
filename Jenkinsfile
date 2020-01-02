node {
    def server = Artifactory.server 'artifactory' 
    def rtMaven = Artifactory.newMavenBuild()
    def buildInfo
    def mvnHome
    jdk = tool name: 'JAVA'
    env.JAVA_HOME = "${jdk}"
    
   stage ('Clone') {                                           
       git branch: 'master', url: "https://github.com/Nehawadhwa1989/SpringBoot-Demo.git"
                              }
               stage ('Artifactory configuration') {
        mvnHome = tool 'mavenhome'
        rtMaven.tool = 'mavenhome' // Tool name from Jenkins configuration
        rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local', server: server
        rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
        buildInfo = Artifactory.newBuildInfo()
        buildInfo.env.capture = true
    }                        
               stage ('Maven Build') {
                   rtMaven.run pom: 'pom.xml', goals: 'clean package', buildInfo: buildInfo
    }
   
               stage('Results') {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }          

               stage ('Artifactory Build Publish') {
     server.publishBuildInfo buildInfo
    }
    stage ('Deploy'){
        sh "wget --user admin --password password http://localhost:8081/artifactory/libs-release-local/org/springframework/gs-spring-boot/0.1.0/gs-spring-boot-0.1.0.jar"
        sh "java -jar gs-spring-boot-0.1.0.jar"
    }
         
}
