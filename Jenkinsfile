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
               sh "docker tag d567cef3224c senzxita/todooly-frontend:latest" 
               sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
               sh "docker push senzxita/todooly-frontend:latest"
               //sh "docker-compose push senzxita/todooly-frontend:latest"
                             
               
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
