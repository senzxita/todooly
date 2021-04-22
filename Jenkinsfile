pipeline {

    agent any

    environment {
        //TF_WORKSPACE = 'dev'
        //TF_IN_AUTOMATION = 'true'
        registry = "https://hub.docker.com/repository/docker/senzxita"
        registryCredential = "Docker-hub-cred"
        
        

        COMPOSE_FILE = "docker-compose.yml"
        
    }

    stages {
        stage('Build images') {
            steps {
               
               sh "docker-compose build"
               sh "docker tag d567cef3224c senzxita/todolly-frontend:latest"
               sh "docker tag 4a797949b4cd senzxita/todooly-api:latest"

              // sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"

               sh "docker login -u senzxita -p folakemi1."
                
              // sh "docker login docker.io"

               sh "docker push senzxita/todooly-frontend:latest"
               //sh "docker push senzxita/sca_final_project:latest"
               sh "docker-compose push senzxita/todooly-api:latest"
                             
               
            }
        }

        // stage('Test'){
        //     def testsError = null
        //     try {
        //         sh '''
        //             python manage.py jenkins
        //             deactivate
        //         '''
        //     }
        //     catch(err) {
        //         testsError = err
        //         currentBuild.result = 'FAILURE'
        //     }
        //     finally {
        //         junit 'reports/junit.xml'
        //     }

        //     if (testsError) {
        //         throw testsError
        //     }
        // }

    
        stage('Deploy') {
            steps {
                
                sh "terraform init"
                sh "terraform plan"
                sh "terraform apply -auto-approve"
            }

        }
    


    // post {
    //     always {
    //         sh "docker-compose down || true"
    //     }
    }
}
