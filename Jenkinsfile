pipeline {
  agent {
    docker {
      image 'docker:stable-dind'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    GITHUB_CREDENTIALS = credentials('github')
    DOCKER_IMAGE = 'labbtest/nodejs-project'
  }

  stages {
    stage('Clone Repository') {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'https://github.com/lab-testt/Nodejs-PostgreSQL.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build("${DOCKER_IMAGE}:latest")
        }
      }
    }

    stage('Docker Login and Push') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
            sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
          }
          dockerImage.push('latest')
        }
      }
    }

    stage('Install Docker Compose') {
      steps {
        sh '''
          apk update
          apk add --no-cache curl jq
          COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
          curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
          chmod +x /usr/local/bin/docker-compose
          docker-compose --version
        '''
      }
    }

    stage('Deploy') {
      steps {
        sh 'docker-compose -f docker-compose.yml up -d'
      }
    }
  }
}
