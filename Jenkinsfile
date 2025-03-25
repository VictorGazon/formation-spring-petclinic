pipeline {
    agent any
    
    tools {
        jdk 'localJDK'
        maven 'localMaven'
    }
    
    environment {
        SONAR_SCANNER_HOME = tool 'SonarQube Scanner'
        PROJECT_KEY = 'spring-petclinic'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Récupération du code
                checkout scm
            }
        }
        
        stage('Build & Unit Tests') {
            steps {
                // Compilation et exécution des tests unitaires
                sh 'mvn clean verify'
                
                // Publication des résultats de tests JUnit
                junit '**/target/surefire-reports/*.xml'
            }
        }
        
        stage('Code Coverage') {
            steps {
                // Génération du rapport JaCoCo
                sh 'mvn jacoco:report'
                
                // Publication du rapport de couverture
                jacoco(
                    execPattern: 'target/jacoco.exec',
                    classPattern: 'target/classes',
                    sourcePattern: 'src/main/java',
                    exclusionPattern: 'src/test/**'
                )
            }
        }
        
        stage('Code Analysis') {
            steps {
                // Exécution de Checkstyle
                sh 'mvn checkstyle:checkstyle'
                
                // Publication des rapports d'analyse
                recordIssues(
                    tools: [
                        checkStyle(pattern: 'target/checkstyle-result.xml')
                    ]
                )
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                // Analyse SonarQube
                withSonarQubeEnv('SonarQube') {
                    sh "${SONAR_SCANNER_HOME}/bin/sonar-scanner"
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                // Vérification du Quality Gate SonarQube
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
    
    post {
        always {
            // Nettoyage de l'espace de travail
            cleanWs()
        }
        success {
            echo 'Pipeline terminé avec succès. Tous les critères de qualité sont respectés.'
        }
        failure {
            echo 'Pipeline échoué. Vérifiez les rapports d\'analyse pour identifier les problèmes.'
        }
    }
}
