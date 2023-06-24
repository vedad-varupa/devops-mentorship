Task-13:

https://catalog.us-east-1.prod.workshops.aws/workshops/752fd04a-f7c3-49a0-a9a0-c9b5ed40061b/en-US

# To do:
Lab 1: AWS CodeCommit
Lab 2: AWS CodeArtifact
Lab 3: AWS CodeBuild
Lab 4: AWS CodeDeploy
Lab 5: AWS CodePipeline

# Commands used in this task-13:

1. Install Apache Maven using the commands below (enter them in the terminal prompt of Cloud9):

sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven


2. Maven comes with Java 7. For the build image that we're going to use later on we will need to use at least Java 8. Therefore we are going to install Java 8, or more specifically Amazon Correto 8 , which is a free, production-ready distribution of the Open Java Development Kit (OpenJDK) provided by Amazon:

sudo amazon-linux-extras enable corretto8
sudo yum install -y java-1.8.0-amazon-corretto-devel
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64
export PATH=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/jre/bin/:$PATH

3. Verify that Java 8 and Maven are installed correctly:

java -version
mvn -v

4. Use mvn to generate a sample Java web app

mvn archetype:generate \
    -DgroupId=com.wildrydes.app \
    -DartifactId=unicorn-web-project \
    -DarchetypeArtifactId=maven-archetype-webapp \
    -DinteractiveMode=false

5. Select Clone URL and Clone HTTPS

https://git-codecommit.us-east-1.amazonaws.com/v1/repos/unicorn-web-project  


6. setup your Git identity 

git config --global user.name "vedad.varupa"
git config --global user.email varupa.vedad@hotmail.com

7. Init the local repo and set the remote origin to the CodeCommit URL

cd ~/environment/unicorn-web-project
git init -b main
git remote add origin https://git-codecommit.us-east-1.amazonaws.com/v1/repos/unicorn-web-project  

8. Commit and push our code

git add *
git commit -m "Initial commit"
git push -u origin main

9. Export a CodeArtifact authorization token for authorization to your repository from your preferred shell

export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain unicorns --domain-owner 130869273046 --region us-east-1 --query authorizationToken --output text`

10. Verify if the application can be compiled successfully locally in Cloud9 using the settings file

mvn -s settings.xml compile
