pipeline {

    agent any

    environment {
        //TF_WORKSPACE = 'dev'
        //TF_IN_AUTOMATION = 'true'
        TF_FILE = "main.tf"
        credentials = file("sca-project-310411-060cb71eb513.json")
        project = "Cloud-School-Project"

        COMPOSE_FILE = "docker-compose.yml"
        
    }

    stages {
        stage('Build images') {
            steps {
               
               sh "docker-compose build"
               sh "docker login"
               sh "docker-compose push senzxita/todooly-api:latest"
               sh "docker-compose push senzxita/todooly-frontend:latest"
                             
               
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
