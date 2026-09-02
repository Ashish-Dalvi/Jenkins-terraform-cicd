pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script 
                        {
                            git "https://github.com/Ashish-Dalvi/Jenkins-terraform-cicd.git"
                        }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd; terraform/; terraform init'
                sh "pwd; terraform/; terraform plan -out tfplan"
                sh 'pwd; terraform/; terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd; terraform/; terraform apply -input=false tfplan"
            }
        }
    }

  }