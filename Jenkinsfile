pipeline {

    parameters {
        booleanParam(
            name: 'autoApprove',
            defaultValue: false,
            description: 'Automatically run apply after generating plan?'
        )

        booleanParam(
            name: 'DESTROY',
            defaultValue: false,
            description: 'Destroy Terraform infrastructure instead of deploying?'
        )
    }

    agent any

    stages {

        stage('Checkout') {
            steps {
                script {
                    dir("terraform") {
                        git "https://github.com/Ashish-Dalvi/Jenkins-terraform-cicd.git"
                    }
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                    cd terraform
                    terraform init
                '''
            }
        }

        stage('Plan') {
            when {
                expression {
                    !params.DESTROY
                }
            }

            steps {
                sh '''
                    cd terraform
                    terraform plan -out tfplan
                    terraform show -no-color tfplan > tfplan.txt
                '''
            }
        }

        stage('Approval - Apply') {
            when {
                expression {
                    !params.DESTROY && !params.autoApprove
                }
            }

            steps {
                script {
                    def plan = readFile 'terraform/tfplan.txt'

                    input(
                        message: "Do you want to apply the Terraform plan?",
                        parameters: [
                            text(
                                name: 'Plan',
                                description: 'Please review the plan',
                                defaultValue: plan
                            )
                        ]
                    )
                }
            }
        }

        stage('Apply') {
            when {
                expression {
                    !params.DESTROY
                }
            }

            steps {
                sh '''
                    cd terraform
                    terraform apply -input=false tfplan
                '''
            }
        }

        stage('Destroy Plan') {
            when {
                expression {
                    params.DESTROY
                }
            }

            steps {
                sh '''
                    cd terraform
                    terraform plan -destroy -out destroy.tfplan
                    terraform show -no-color destroy.tfplan > destroy-plan.txt
                '''
            }
        }

        stage('Destroy Approval') {
            when {
                expression {
                    params.DESTROY
                }
            }

            steps {
                script {
                    def destroyPlan = readFile 'terraform/destroy-plan.txt'

                    input(
                        message: "⚠️ WARNING: Do you want to DESTROY all Terraform resources?",
                        parameters: [
                            text(
                                name: 'DestroyPlan',
                                description: 'Review the resources that will be destroyed',
                                defaultValue: destroyPlan
                            )
                        ]
                    )
                }
            }
        }

        stage('Destroy') {
            when {
                expression {
                    params.DESTROY
                }
            }

            steps {
                sh '''
                    cd terraform
                    terraform apply -input=false destroy.tfplan
                '''
            }
        }
    }
}