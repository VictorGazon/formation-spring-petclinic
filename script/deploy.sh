# Créez le fichier de configuration STAGING

cat > src/main/resources/env/application-staging.properties << EOF

# Configuration spécifique à l'environnement STAGING

spring.profiles.active=staging
 
# Configuration de la base de données

spring.datasource.url=jdbc:mysql://192.168.56.14:3306/petclinic_staging?useSSL=false&allowPublicKeyRetrieval=true

spring.datasource.username=petclinic

spring.datasource.password=petclinic

spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
 
# Configuration JPA/Hibernate

spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=true
 
# Configuration du serveur

server.port=8080

server.servlet.context-path=/petclinic-staging
 
# Configuration de l'application

petclinic.environment=STAGING

petclinic.version=1.0.0

EOF

 
# Créez le fichier de configuration PROD

cat > src/main/resources/env/application-prod.properties << EOF

# Configuration spécifique à l'environnement PROD

spring.profiles.active=prod
 
# Configuration de la base de données

spring.datasource.url=jdbc:mysql://192.168.56.14:3306/petclinic_prod?useSSL=false&allowPublicKeyRetrieval=true

spring.datasource.username=petclinic

spring.datasource.password=petclinic

spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
 
# Configuration JPA/Hibernate

spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=false
 
# Configuration du serveur

server.port=8080

server.servlet.context-path=/petclinic-prod
 
# Configuration de l'application

petclinic.environment=PRODUCTION

petclinic.version=1.0.0

EOF
 
 
#!/bin/bash

# Script de déploiement pour Spring Petclinic

# Usage: ./deploy.sh <DEPLOY_ENV> <WAR_FILE>
 
set -e  # Arrêt en cas d'erreur
 
# Vérification des arguments

if [ $# -ne 2 ]; then

    echo "Usage: $0 <DEPLOY_ENV> <WAR_FILE>"

    echo "Exemple: $0 STAGING target/petclinic.war"

    exit 1

fi
 
DEPLOY_ENV=$1

WAR_FILE=$2
 
# Vérification de l'existence du fichier WAR

if [ ! -f "$WAR_FILE" ]; then

    echo "Erreur: Le fichier $WAR_FILE n'existe pas."

    exit 1

fi
 
# Configuration selon l'environnement

if [ "$DEPLOY_ENV" = "STAGING" ]; then

    TOMCAT_URL="http://192.168.56.13:8080"

    CONTEXT_PATH="petclinic-staging"

    PROFILE="staging"

elif [ "$DEPLOY_ENV" = "PROD" ]; then

    TOMCAT_URL="http://192.168.56.13:8080"

    CONTEXT_PATH="petclinic-prod"

    PROFILE="prod"

else

    echo "Erreur: Environnement inconnu: $DEPLOY_ENV"

    echo "Les valeurs valides sont STAGING ou PROD"

    exit 1

fi
 
# Récupérer la version actuelle

VERSION=$(grep -m 1 "<version>" pom.xml | sed -E 's/.*<version>(.*)<\/version>.*/\1/')
 
echo "=== Déploiement de Spring Petclinic $VERSION sur $DEPLOY_ENV ==="

echo "URL Tomcat: $TOMCAT_URL"

echo "Contexte: $CONTEXT_PATH"

echo "Profil: $PROFILE"
 
# Déploiement sur Tomcat

echo "Déploiement du fichier WAR sur Tomcat..."
 
# Utiliser curl pour déployer via l'API Manager de Tomcat

curl -v -u deployer:deployer -T "$WAR_FILE" \

    "$TOMCAT_URL/manager/text/deploy?path=/$CONTEXT_PATH&update=true"
 
# Vérification du déploiement

echo "Vérification du déploiement..."

RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TOMCAT_URL/$CONTEXT_PATH")
 
if [ "$RESPONSE_CODE" = "200" ] || [ "$RESPONSE_CODE" = "302" ]; then

    echo "=== Déploiement réussi ! ==="

    echo "Application accessible à: $TOMCAT_URL/$CONTEXT_PATH"

else

    echo "=== Échec du déploiement ! ==="

    echo "Code de réponse HTTP: $RESPONSE_CODE"

    echo "Vérifiez les logs Tomcat pour plus d'informations."

    exit 1

fi

 # Créez le fichier de configuration STAGING

cat > src/main/resources/env/application-staging.properties << EOF

# Configuration spécifique à l'environnement STAGING

spring.profiles.active=staging
 
# Configuration de la base de données

spring.datasource.url=jdbc:mysql://192.168.56.14:3306/petclinic_staging?useSSL=false&allowPublicKeyRetrieval=true

spring.datasource.username=petclinic

spring.datasource.password=petclinic

spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
 
# Configuration JPA/Hibernate

spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=true
 
# Configuration du serveur

server.port=8080

server.servlet.context-path=/petclinic-staging
 
# Configuration de l'application

petclinic.environment=STAGING

petclinic.version=1.0.0

EOF

 
# Créez le fichier de configuration PROD

cat > src/main/resources/env/application-prod.properties << EOF

# Configuration spécifique à l'environnement PROD

spring.profiles.active=prod
 
# Configuration de la base de données

spring.datasource.url=jdbc:mysql://192.168.56.14:3306/petclinic_prod?useSSL=false&allowPublicKeyRetrieval=true

spring.datasource.username=petclinic

spring.datasource.password=petclinic

spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
 
# Configuration JPA/Hibernate

spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=false
 
# Configuration du serveur

server.port=8080

server.servlet.context-path=/petclinic-prod
 
# Configuration de l'application

petclinic.environment=PRODUCTION

petclinic.version=1.0.0

EOF
 
 
#!/bin/bash

# Script de déploiement pour Spring Petclinic

# Usage: ./deploy.sh <DEPLOY_ENV> <WAR_FILE>
 
set -e  # Arrêt en cas d'erreur
 
# Vérification des arguments

if [ $# -ne 2 ]; then

    echo "Usage: $0 <DEPLOY_ENV> <WAR_FILE>"

    echo "Exemple: $0 STAGING target/petclinic.war"

    exit 1

fi
 
DEPLOY_ENV=$1

WAR_FILE=$2
 
# Vérification de l'existence du fichier WAR

if [ ! -f "$WAR_FILE" ]; then

    echo "Erreur: Le fichier $WAR_FILE n'existe pas."

    exit 1

fi
 
# Configuration selon l'environnement

if [ "$DEPLOY_ENV" = "STAGING" ]; then

    TOMCAT_URL="http://192.168.56.13:8080"

    CONTEXT_PATH="petclinic-staging"

    PROFILE="staging"

elif [ "$DEPLOY_ENV" = "PROD" ]; then

    TOMCAT_URL="http://192.168.56.13:8080"

    CONTEXT_PATH="petclinic-prod"

    PROFILE="prod"

else

    echo "Erreur: Environnement inconnu: $DEPLOY_ENV"

    echo "Les valeurs valides sont STAGING ou PROD"

    exit 1

fi
 
# Récupérer la version actuelle

VERSION=$(grep -m 1 "<version>" pom.xml | sed -E 's/.*<version>(.*)<\/version>.*/\1/')
 
echo "=== Déploiement de Spring Petclinic $VERSION sur $DEPLOY_ENV ==="

echo "URL Tomcat: $TOMCAT_URL"

echo "Contexte: $CONTEXT_PATH"

echo "Profil: $PROFILE"
 
# Déploiement sur Tomcat

echo "Déploiement du fichier WAR sur Tomcat..."
 
# Utiliser curl pour déployer via l'API Manager de Tomcat

curl -v -u deployer:deployer -T "$WAR_FILE" \

    "$TOMCAT_URL/manager/text/deploy?path=/$CONTEXT_PATH&update=true"
 
# Vérification du déploiement

echo "Vérification du déploiement..."

RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TOMCAT_URL/$CONTEXT_PATH")
 
if [ "$RESPONSE_CODE" = "200" ] || [ "$RESPONSE_CODE" = "302" ]; then

    echo "=== Déploiement réussi ! ==="

    echo "Application accessible à: $TOMCAT_URL/$CONTEXT_PATH"

else

    echo "=== Échec du déploiement ! ==="

    echo "Code de réponse HTTP: $RESPONSE_CODE"

    echo "Vérifiez les logs Tomcat pour plus d'informations."

    exit 1

fi

 