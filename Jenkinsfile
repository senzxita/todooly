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
               echo 'building the frontend of the application...'
               sh 'sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
               sh "sudo chmod +x /usr/local/bin/docker-compose"
               sh "echo $PATH"
               sh "docker-compose build"
                             
               
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
                sh "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -"
                sh 'sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"'
                sh "sudo apt install terraform"
                sh "terraform init"
                sh "terraform plan"
                sh "terraform apply"
            }

        }
    


    // post {
    //     always {
    //         sh "docker-compose down || true"
    //     }
    }
}
