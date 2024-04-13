

User
je dois créer une pipeline pour mon projet devops que j'ai crée en mvc/php/sql/js/css/html maintenant mon docker file est ceci :

FROM php:7.4-apache

# Installation des dépendances PHP nécessaires
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copier les fichiers de l'application dans le répertoire de travail du conteneur
COPY . /var/www/html

# Copier le fichier SQL dans le conteneur
COPY sql/dump.sql /docker-entrypoint-initdb.d/dump.sql

# Exposer le port 80 pour accéder à l'application via le navigateur
EXPOSE 80


et docker-compose :

version: '3'

services:
  web:
    build: .
    ports:
      - "8081:80"
    depends_on:
      - db
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: autoecole
      MYSQL_PASSWORD: root
    volumes:
      - ./sql:/docker-entrypoint-initdb.d


que devrait être le code de mon fichier Jenkinsfile pour que ma pipeline marche ?
ChatGPT
Voici un exemple de Jenkinsfile pour votre pipeline DevOps avec Docker :

groovy
Copy code
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    docker.build("mon_projet_devops:latest")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Démarrer les conteneurs Docker
                    docker.image("mon_projet_devops:latest").withRun('-p 8081:80 --name mon_projet_devops --link db:mysql') { c ->
                        // Attendre que le conteneur soit prêt
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                // Ajoutez vos tests ici
            }
        }
        stage('Deploy') {
            steps {
                // Déploiement de l'application (si nécessaire)
            }
        }
    }
    post {
        always {
            // Nettoyer les ressources Docker
            cleanWs()
            sh 'docker stop mon_projet_devops || true'
            sh 'docker rm mon_projet_devops || true'
        }
    }
}
Assurez-vous d'ajuster les noms des images Docker (mon_projet_devops:latest) et des conteneurs Docker (mon_projet_devops) selon votre projet.

Ce Jenkinsfile effectue les actions suivantes :

Construire l'image Docker à partir du Dockerfile.
Démarrer un conteneur Docker à partir de l'image construite.
Attendre que le conteneur soit prêt en vérifiant son accessibilité via une requête HTTP.
Exécuter des tests (vous devrez ajouter vos tests dans la section appropriée).
Déployer l'application (vous devrez ajouter les étapes de déploiement si nécessaire).
Nettoyer les ressources Docker en arrêtant et en supprimant le conteneur.
User
pour ceci je ne sais pas ce que c'est : 

Assurez-vous d'ajuster les noms des images Docker (mon_projet_devops:latest) et des conteneurs Docker (mon_projet_devops) selon votre projet.
ChatGPT
Ce passage du code fait référence aux noms que vous souhaitez donner à votre image Docker et à votre conteneur Docker.

Image Docker: L'image Docker est essentiellement un modèle qui contient les instructions pour créer un conteneur Docker. Lorsque vous exécutez docker build, vous créez une image Docker. Vous pouvez nommer cette image selon vos préférences, par exemple, en utilisant le nom de votre projet ou une description pertinente, suivi de :latest pour indiquer qu'il s'agit de la dernière version. Par exemple, mon_projet_devops:latest.

Conteneur Docker: Le conteneur Docker est une instance en cours d'exécution d'une image Docker. Lorsque vous exécutez docker run, vous créez un conteneur Docker. Vous pouvez également nommer ce conteneur selon vos préférences. Dans le code, mon_projet_devops est utilisé comme nom du conteneur.

Assurez-vous de remplacer ces noms par ceux qui conviennent le mieux à votre projet. Par exemple, si votre projet s'appelle "auto-ecole-app", vous pouvez nommer votre image Docker auto-ecole-app:latest et votre conteneur Docker auto-ecole-container. Assurez-vous simplement de rester cohérent avec ces noms tout au long de votre pipeline et de vos scripts.

User
comment modifier le nom de l'image ou dois-je le faire
ChatGPT
Pour modifier le nom de l'image Docker dans le Jenkinsfile, vous devez ajuster l'argument passé à la fonction docker.build. Voici où vous pouvez le faire dans le Jenkinsfile fourni :

groovy
Copy code
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker en ajustant le nom
                    docker.build("nouveau_nom_image:latest") // Modifier ici
                }
            }
        }
        // Les autres étapes restent inchangées
    }
    // Les autres parties du Jenkinsfile restent inchangées
}
Remplacez "nouveau_nom_image:latest" par le nom que vous souhaitez donner à votre image Docker. Par exemple, si votre projet s'appelle "mon_projet_devops", vous pouvez utiliser mon_projet_devops:latest. Assurez-vous que le nouveau nom suive le même modèle que nom_image:tag.

User
j'ai des erreurs en lançant le build : 

Started by user zYusei
Obtained Jenkinsfile from git https://github.com/zYusei/Projet-Devops.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/Projet-Devops
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
The recommended git tool is: git
No credentials specified
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/Projet-Devops/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/zYusei/Projet-Devops.git # timeout=10
Fetching upstream changes from https://github.com/zYusei/Projet-Devops.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
 > git fetch --tags --force --progress -- https://github.com/zYusei/Projet-Devops.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 4abeb9c885c9b408d156d8869dd2e691ea54ecc7 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 4abeb9c885c9b408d156d8869dd2e691ea54ecc7 # timeout=10
Commit message: "Modify jenkins file"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Build Docker Image)
[Pipeline] script
[Pipeline] {
[Pipeline] isUnix
[Pipeline] withEnv
[Pipeline] {
[Pipeline] sh
+ docker build -t projet_devops:latest .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from dockerfile
#1 transferring dockerfile: 440B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/php:7.4-apache
#2 DONE 0.9s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/4] FROM docker.io/library/php:7.4-apache@sha256:c9d7e608f73832673479770d66aacc8100011ec751d1905ff63fae3fe2e0ca6d
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 27.04kB 0.0s done
#5 DONE 0.0s

#6 [2/4] RUN docker-php-ext-install mysqli pdo pdo_mysql
#6 CACHED

#7 [3/4] COPY . /var/www/html
#7 DONE 0.5s

#8 [4/4] COPY sql/dump.sql /docker-entrypoint-initdb.d/dump.sql
#8 DONE 0.0s

#9 exporting to image
#9 exporting layers
#9 exporting layers 0.2s done
#9 writing image sha256:f6cb23d714a676d7f85c3db80be5d104cdaaa39c0d27ecd66755d81f1f383e5b done
#9 naming to docker.io/library/projet_devops:latest done
#9 DONE 0.2s
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run Docker Container)
[Pipeline] script
[Pipeline] {
[Pipeline] isUnix
[Pipeline] sh
+ docker run -d -p 8081:80 --name projet_devops --link db:mysql projet_devops:latest
docker: Error response from daemon: could not get container for db: No such container: db.
See 'docker run --help'.
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Test)
Stage "Test" skipped due to earlier failure(s)
[Pipeline] getContext
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Deploy)
Stage "Deploy" skipped due to earlier failure(s)
[Pipeline] getContext
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] cleanWs
[WS-CLEANUP] Deleting project workspace...
[WS-CLEANUP] Deferred wipeout is used...
[WS-CLEANUP] done
[Pipeline] sh
+ docker stop projet_devops
Error response from daemon: No such container: projet_devops
+ true
[Pipeline] sh
+ docker rm projet_devops
Error response from daemon: No such container: projet_devops
+ true
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 125
Finished: FAILURE
ChatGPT
Il semble que l'erreur se produise lorsque le conteneur Docker essaie de démarrer en raison d'une référence à un conteneur nommé "db", qui n'existe pas dans la configuration Docker Compose fournie.

Dans votre fichier docker-compose.yml, vous avez défini un service appelé db, mais cela ne garantit pas que le conteneur Docker pour ce service sera nommé "db". Par défaut, Docker Compose crée un réseau pour les services et nomme les conteneurs en conséquence.

Pour résoudre cette erreur, vous pouvez :

Renommer le service db dans votre fichier docker-compose.yml pour qu'il corresponde au nom utilisé dans votre pipeline Jenkinsfile.
Utiliser le nom du service db dans le Jenkinsfile au lieu de référencer directement le conteneur. Docker Compose permet aux conteneurs de se référer à d'autres conteneurs par leur nom de service.
Voici comment modifier le Jenkinsfile pour utiliser le nom du service db au lieu du nom du conteneur :

groovy
Copy code
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker en ajustant le nom
                    docker.build("nouveau_nom_image:latest") // Modifier ici
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Démarrer les conteneurs Docker
                    docker.image("nouveau_nom_image:latest").withRun('-p 8081:80 --name nouveau_nom_conteneur --link db:mysql') { c ->
                        // Attendre que le conteneur soit prêt
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        // Les autres étapes restent inchangées
    }
    // Les autres parties du Jenkinsfile restent inchangées
}
Assurez-vous de remplacer "nouveau_nom_image" par le nom de votre image Docker et "nouveau_nom_conteneur" par le nom de votre conteneur Docker.

User
comment savoir le nom de mon image docker
ChatGPT
Pour connaître le nom de votre image Docker, vous pouvez utiliser la commande docker images. Voici comment faire :

Ouvrez votre terminal ou votre invite de commande.

Exécutez la commande suivante :

bash
Copy code
docker images
Cela affichera une liste de toutes les images Docker présentes sur votre système, avec leurs noms, tags, ID et autres informations pertinentes.

Recherchez le nom de l'image que vous avez construite pour votre projet DevOps. Par exemple, si vous avez suivi les instructions précédentes et que vous avez utilisé le nom nouveau_nom_image, vous devriez voir cette image répertoriée dans les résultats de la commande docker images.

Une fois que vous avez trouvé le nom de votre image Docker, vous pouvez l'utiliser dans votre Jenkinsfile pour référencer l'image à exécuter dans vos conteneurs Docker.

User
i have this in my images please update the script according to this : 

REPOSITORY                TAG       IMAGE ID       CREATED         SIZE
projet_devops             latest    f6cb23d714a6   8 minutes ago   538MB
projet-devops-web         latest    85e93471e8b1   3 days ago      538MB
ppe-auto-ecole-main-web   latest    55fffbc7737b   3 days ago      538MB
<none>                    <none>    61878de08284   3 days ago      538MB
<none>                    <none>    3f2dfdf3947a   3 days ago      538MB
<none>                    <none>    fcf6de239de6   8 days ago      497MB
<none>                    <none>    5e652406e27e   8 days ago      496MB
<none>                    <none>    57c9b964cadc   8 days ago      497MB
<none>                    <none>    57b6b120e0f3   8 days ago      497MB
<none>                    <none>    27a6bac795f0   8 days ago      497MB
<none>                    <none>    41bfa814b7bb   8 days ago      496MB
<none>                    <none>    51137d282c65   8 days ago      497MB
<none>                    <none>    24bcd3fe1aef   8 days ago      497MB
<none>                    <none>    099fa67fdfaa   8 days ago      501MB
ppe-auto-ecole-main_web   latest    c6bcc94e36ff   8 days ago      497MB
<none>                    <none>    657b5b73c0de   8 days ago      497MB
<none>                    <none>    4a3e044bd2b8   8 days ago      497MB
<none>                    <none>    823f25fb7294   8 days ago      497MB
<none>                    <none>    00c0dae9efc9   8 days ago      497MB
mysql                     5.7       5107333e08a8   4 months ago    501MB
ChatGPT
Based on the output of docker images, it seems that your image for the project is named projet_devops with the tag latest. You can use this information in your Jenkinsfile.

Here's the updated Jenkinsfile with the corrected image name:

groovy
Copy code
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with the correct name
                    docker.build("projet_devops:latest")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Start Docker container
                    docker.image("projet_devops:latest").withRun('-p 8081:80 --name projet_devops --link db:mysql') { c ->
                        // Wait until the container is ready
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        // Other stages remain unchanged
    }
    // Other parts of the Jenkinsfile remain unchanged
}
Make sure to replace any occurrence of nouveau_nom_image and nouveau_nom_conteneur with projet_devops in your Jenkinsfile. This should resolve the issue with starting the Docker container.

User
when i start my docker the imagess starting are this : 

 ✔ Container ppe-auto-ecole-main-db-1   Created                            0.0s 
 ✔ Container ppe-auto-ecole-main-web-1  Recreated                          0.0s 
Attaching to db-1, web-1

so change according to this the jenkinsfile
ChatGPT
Got it. It seems like your Docker Compose project prefixes the service names with ppe-auto-ecole-main-, so the container names are prefixed as well. Let's adjust the Jenkinsfile accordingly:

groovy
Copy code
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with the correct name
                    docker.build("projet_devops:latest")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Start Docker container
                    docker.image("projet_devops:latest").withRun('-p 8081:80 --name ppe-auto-ecole-main-web --link db:mysql') { c ->
                        // Wait until the container is ready
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        // Other stages remain unchanged
    }
    // Other parts of the Jenkinsfile remain unchanged
}
In this Jenkinsfile, I've adjusted the name of the container to match the one created by your Docker Compose project. Now, the container name in the docker.image().withRun() section is set to ppe-auto-ecole-main-web, which should match the name of the container created by Docker Compose.

User
send the entire jenkinsfile please i have this version, send the modified one :

pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    docker.build("projet_devops:latest")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Démarrer les conteneurs Docker
                    docker.image("projet_devops:latest").withRun('-p 8081:80 --name projet_devops --link db:mysql') { c ->
                        // Attendre que le conteneur soit prêt
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'

            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                
            }
        }
    }
    post {
        always {
            // Nettoyer les ressources Docker
            cleanWs()
            sh 'docker stop projet_devops || true'
            sh 'docker rm projet_devops || true'
        }
    }
}
ChatGPT
Here's the modified Jenkinsfile:

groovy
Copy code
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with the correct name
                    docker.build("projet_devops:latest")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Start Docker container
                    docker.image("projet_devops:latest").withRun('-p 8081:80 --name ppe-auto-ecole-main-web --link db:mysql') { c ->
                        // Wait until the container is ready
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add your test steps here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment steps here
            }
        }
    }
    post {
        always {
            // Clean up Docker resources
            cleanWs()
            sh 'docker stop ppe-auto-ecole-main-web || true'
            sh 'docker rm ppe-auto-ecole-main-web || true'
        }
    }
}
I've updated the name of the Docker container to match the one created by your Docker Compose project (ppe-auto-ecole-main-web). Additionally, the cleanup commands in the post section now use the correct container name.

User
i have this error : 

Started by user zYusei
Obtained Jenkinsfile from git https://github.com/zYusei/Projet-Devops.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/Projet-Devops
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
The recommended git tool is: git
No credentials specified
Cloning the remote Git repository
Cloning repository https://github.com/zYusei/Projet-Devops.git
 > git init /var/lib/jenkins/workspace/Projet-Devops # timeout=10
Fetching upstream changes from https://github.com/zYusei/Projet-Devops.git
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
 > git fetch --tags --force --progress -- https://github.com/zYusei/Projet-Devops.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/zYusei/Projet-Devops.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 5533f4ea36a957cbec61cf27943009cd54c14790 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 5533f4ea36a957cbec61cf27943009cd54c14790 # timeout=10
Commit message: "modified jenkinsfile"
 > git rev-list --no-walk 4abeb9c885c9b408d156d8869dd2e691ea54ecc7 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Build Docker Image)
[Pipeline] script
[Pipeline] {
[Pipeline] isUnix
[Pipeline] withEnv
[Pipeline] {
[Pipeline] sh
+ docker build -t projet_devops:latest .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from dockerfile
#1 transferring dockerfile: 440B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/php:7.4-apache
#2 DONE 0.5s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/4] FROM docker.io/library/php:7.4-apache@sha256:c9d7e608f73832673479770d66aacc8100011ec751d1905ff63fae3fe2e0ca6d
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 84.66MB 0.8s done
#5 DONE 0.8s

#6 [2/4] RUN docker-php-ext-install mysqli pdo pdo_mysql
#6 CACHED

#7 [3/4] COPY . /var/www/html
#7 DONE 0.4s

#8 [4/4] COPY sql/dump.sql /docker-entrypoint-initdb.d/dump.sql
#8 DONE 0.0s

#9 exporting to image
#9 exporting layers 0.1s done
#9 writing image sha256:5ca1f8aefe0749c6360ef64a655cded7eecb291dfb4e9035ebc1e0ea967906b3
#9 writing image sha256:5ca1f8aefe0749c6360ef64a655cded7eecb291dfb4e9035ebc1e0ea967906b3 done
#9 naming to docker.io/library/projet_devops:latest done
#9 DONE 0.1s
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run Docker Container)
[Pipeline] script
[Pipeline] {
[Pipeline] isUnix
[Pipeline] sh
+ docker run -d -p 8081:80 --name ppe-auto-ecole-main-web --link db:mysql projet_devops:latest
docker: Error response from daemon: could not get container for db: No such container: db.
See 'docker run --help'.
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Test)
Stage "Test" skipped due to earlier failure(s)
[Pipeline] getContext
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Deploy)
Stage "Deploy" skipped due to earlier failure(s)
[Pipeline] getContext
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] cleanWs
[WS-CLEANUP] Deleting project workspace...
[WS-CLEANUP] Deferred wipeout is used...
[WS-CLEANUP] done
[Pipeline] sh
+ docker stop ppe-auto-ecole-main-web
Error response from daemon: No such container: ppe-auto-ecole-main-web
+ true
[Pipeline] sh
+ docker rm ppe-auto-ecole-main-web
Error response from daemon: No such container: ppe-auto-ecole-main-web
+ true
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 125
Finished: FAILURE
ChatGPT
It appears that the issue persists with the Docker container name not being found when trying to link to db. This indicates that Docker is unable to locate the db container, which might be due to the way your Docker Compose project is set up.

Since the container name in your Docker Compose project is prefixed with ppe-auto-ecole-main-, you should ensure that the db container is also named accordingly. Let's update the Jenkinsfile accordingly:

groovy
Copy code
pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with the correct name
                    docker.build("projet_devops:latest")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Start Docker container
                    docker.image("projet_devops:latest").withRun('-p 8081:80 --name ppe-auto-ecole-main-web --link ppe-auto-ecole-main-db:mysql') { c ->
                        // Wait until the container is ready
                        sh 'while ! curl -sSf http://localhost:8081 >/dev/null; do sleep 1; done'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add your test steps here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment steps here
            }
        }
    }
    post {
        always {
            // Clean up Docker resources
            cleanWs()
            sh 'docker stop ppe-auto-ecole-main-web || true'
            sh 'docker rm ppe-auto-ecole-main-web || true'
        }
    }
}
