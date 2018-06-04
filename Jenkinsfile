pipeline {
    agent none 
  /*  parameters {
        string(name: 'S3', defaultValue: 'super-original-name-for-task-bucket-1-upload')
           } */
    tools {
        maven 'maven'
        jdk 'jdk'
    }
    stages {
        stage('Cloning Git repository') {
            agent { label 'master' } 
            steps {
                deleteDir() 
                echo '...cloning GIT repository'
                git 'https://github.com/irynadiudiuk/hiapp.git'
                sh 'pwd' 
                sh 'ls -al' 
                  }
        }
   stage('Build with maven') {
            agent { label 'ja2' } 
            steps {
               /* withMaven(
                maven: ‘maven’)*/
                sh 'pwd' 
                sh 'mvn clean package'
                echo '…build done'
                }
        }

        stage('S3 upload') {
            agent { label 'ja2' } 
               steps {
               echo '...we are uploading file to S3'
               sh 'pwd' 
               s3Upload acl: 'Private', bucket: 'super-original-name-for-task-bucket-1-upload', cacheControl: '', excludePathPattern: '', file: 'target/hiapp.war', path: 'hiapp.war', metadatas: [''], sseAlgorithm: '', workingDir: ''
              
            }
        }
        stage('S3 download') {
            agent { label 'master' } 
               steps {
                 echo '...we are downloading file to tomcat'
                 sh 'sudo systemctl stop tomcat'
                 s3Download(file:'/tmp', bucket:'super-original-name-for-task-bucket-1-upload', path:'hiapp.war', force:true)
                 sh 'cp /tmp/hiapp.war /usr/share/tomcat/webapps/'
                 sh 'sudo systemctl restart tomcat' 
                 emailext body: 'This is a test mail', subject: 'This is a test mail', to: 'is31214@gmail.com'
            }
        }
    
    }
    
}
