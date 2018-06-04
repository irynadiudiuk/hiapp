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
            agent { label 'ja2' } 
            steps {
                /* deleteDir() */
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
                s3Upload acl: 'Private', bucket: 'super-original-name-for-task-bucket-1-upload', cacheControl: '', excludePathPattern: '', file: 'file', path: '.', metadatas: [''], sseAlgorithm: '', workingDir: ''
              
            }
        }
        stage('S3 download') {
            agent { label 'master' } 
               steps {
               echo '...we are uploading file to tomcat'
               s3Download(file:'hiapp.war', bucket:'super-original-name-for-task-bucket-1-upload', path:'/usr/share/tomcat/webapps', force:true)
                /* deleteDir() */
                /*emailext body: 'This is a test mail', subject: 'This is a test mail', to: 'is31214@gmail.com'*/
            }
        }
    
    }
    
}
