# Launch AWS Cloud9 in eu-east-1

* Sign in to AWS as the IAM user you've configured and open the AWS Cloud9 console.
* In the AWS Cloud9 console, choose Create environment.
* Select Create environment
* Name it gitflow-workshop, and take all other defaults
* When it comes up, customize the environment by closing the welcome tab and lower work area, and opening a new terminal tab in the main work area:

![Screenshot-1.png]
![Screenshot-2.png]

# Resize the Cloud9 instance

* By default the Amazon EBS volume attached to the Cloud9 instance is 10 GiB, let's confirm this by typing the following in the terminal:

* df -h

![Screenshot-3.png]

We can see that /dev/xvda1 is 10 GiB and has around 2.1 GiB free.

2.1 GiB of free space isn't enough free space to run this workshop so we need to resize the attached Amazon EBS volume.
The AWS Cloud9 User Guide has instructions on how to Resizing an Amazon EBS volume used by an environment , let's follow the guide.

From the Cloud9 terminal, create a file called resize.sh:

* touch resize.sh

![Screenshot-4.png]

Open resize.sh in Cloud9 and paste the bash script from the documentation:

* From the terminal execute the resize.sh bash script to resize the attached EBS volume to 30 GiB

- $ bash resize.sh 30

![Screenshot-4.png]

Now check the size of the attached EBS volume:

* df -h

![Screenshot-5.png]

# Initial Setup

* The git config command is a convenience function that is used to set Git configuration values on a global or local project level. It is best practice to set up your git user.name and user.email when you set up a new Cloud9 environment using the following commands:

* git config --global user.name "vedad-varupa"
* git config --global user.email varupa.vedad@hotmail.com

![Screenshot-6.png]

# Configure the AWS CLI Credential Helper on Your AWS Cloud9 EC2 Development Environment

* After you've created an AWS Cloud9 environment, you can configure the AWS CLI credential helper to manage the credentials for connections to your CodeCommit repository. The AWS Cloud9 development environment comes with AWS managed temporary credentials that are associated with your IAM user. You use these credentials with the AWS CLI credential helper. The credential helper allows Git to use HTTPS and a cryptographically signed version of your IAM user credentials or Amazon EC2 instance role whenever Git needs to authenticate with AWS to interact with CodeCommit repositories.

* At the terminal, run the following commands to configure the AWS CLI credential helper for HTTPS connections:

- git config --global credential.helper '!aws codecommit credential-helper $@'
- git config --global credential.UseHttpPath true

![Screenshot-7.png]

# Install gitflow

* gitflow is a collection of Git extensions to provide high-level repository operations for Vincent Driessen's branching model . At the terminal, run the following commands to install gitflow:

curl -OL https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
chmod +x gitflow-installer.sh
sudo git config --global url."https://github.com".insteadOf git://github.com
sudo ./gitflow-installer.sh

![Screenshot-7.png]
![Screenshot-8.png]

# AWS Cloudformation

* In this module you will use AWS Cloudformation to set up your application and the infrastructure associated with it. You will leverage AWS Elastic Beanstalk to simplify things.

# Master Branch

# Elastic Beanstalk

* To simplify the process of setting up and configuring EC2 instances for this tutorial, you will spin up a nodejs environment using AWS Elastic Beanstalk. Elastic Beanstalk lets you easily host web applications without needing to launch, configure, or operate virtual servers on your own. It automatically provisions and operates the infrastructure (e.g. virtual servers, load balancers, etc.) and provides the application stack (e.g. OS, language and framework, web and application server, etc.) for you.


# Stage 1: Create Code Commit RepoHeader anchor link

aws codecommit create-repository --repository-name gitflow-workshop --repository-description "Repository for Gitflow Workshop"

![Screenshot-9.png]
![Screenshot-10.png]

git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/gitflow-workshop

![Screenshot-11.png]

# Stage 2: Download the sample code and commit your code to the repository

Download the Sample App archive by running the following command from IDE terminal.

- ASSETURL="https://static.us-east-1.prod.workshops.aws/public/442d5fda-58ca-41f0-9fbe-558b6ff4c71a/assets/workshop-assets.zip"; wget -O gitflow.zip "$ASSETURL"

![Screenshot-12.png]

Unarchive and copy all the contents of the unarchived folder to your local repo folder.

- unzip gitflow.zip -d gitflow-workshop/

![Screenshot-13.png]

Change the directory to your local repo folder. Run git add to stage the change.

- cd gitflow-workshop

![Screenshot-14.png]

- git add -A

![Screenshot-14.png]

Run git commit to commit the change and push it to master

- git commit -m "Initial Commit"

![Screenshot-14.png]

- git push origin master

![Screenshot-15.png]


 # Create Elastic Beanstalk Application

 * To use Elastic Beanstalk we will first create an application, which represents your web application in AWS. In Elastic Beanstalk an application serves as a container for the environments that run your web app, and versions of your web app's source code, saved configurations, logs, and other artifacts that you create while using Elastic Beanstalk.

* Run the following AWS CloudFormation template to create

* Elastic Beanstalk application - think of it as a folder that will hold the components of your Elastic Beanstalk

* S3 bucket for artifacts - place to put your application code before deployment

- aws cloudformation create-stack --template-body file://appcreate.yaml --stack-name gitflow-eb-app

![Screenshot-16.png]

AWS CloudFormation begins creating the resources that are specified in the template. Your new stack, gitflow-eb-app, appears in the list at the top portion of the Cloudformation console . Its status should be CREATE_IN_PROGRESS. You can see detailed status for a stack by viewing its events.

Once the status shows CREATE_COMPLETE Next, go to the Elastic Beanstalk console  in the AWS Management Console to view the application that was created.

![Screenshot-17.png]
![Screenshot-18.png]

# Master Environment
  # Creating an AWS Elastic Beanstalk Master Environment

* You can deploy multiple environments when you need to run multiple versions of an application. For example, you might have development, integration, and production environments

* Use the following AWS CloudFormation templates to set up the elastic beanstalk application and codepipeline to do auto store the artifacts.

- aws cloudformation create-stack --template-body file://envcreate.yaml --parameters file://parameters.json --capabilities CAPABILITY_IAM --stack-name gitflow-eb-master

![Screenshot-19.png]
![Screenshot-20.png]

# AWS CodePipelineHeader 

* AWS CodePipeline is a continuous delivery service you can use to model, visualize, and automate the steps required to release your software. You can quickly model and configure the different stages of a software release process. CodePipeline automates the steps required to release your software changes continuously.

Above cloudformation template will also create and configure a simple AWS CodePipeline with three actions: source, build and deploy.

![Screenshot-21.png]

# Lambda

* AWS Lambda is a compute service that lets you run code without provisioning or managing servers. AWS Lambda executes your code only when needed and scales automatically, from a few requests per day to thousands per second. You pay only for the compute time you consume - there is no charge when your code is not running. With AWS Lambda, you can run code for virtually any type of application or backend service - all with zero administration.

For this workshop we are using lambda function to create codepipeline and elasticbeanstalk when a branch or tag is created.

![Screenshot-22.png]


# Create Lambda

* You can configure a CodeCommit repository so that code pushes or other events trigger actions, such as invoking a function in AWS Lambda. The following steps include creating a Lambda function which will be used with a CodeCommit trigger.

- aws cloudformation create-stack --template-body file://lambda/lambda-create.yaml --stack-name gitflow-workshop-lambda --capabilities CAPABILITY_IAM

![Screenshot-23.png]
![Screenshot-24.png]
![Screenshot-25.png]

# AWS CodeCommit Trigger
* You can configure a CodeCommit repository so that code pushes or other events trigger actions, such as sending a notification from Amazon Simple Notification Service (Amazon SNS) or invoking a function in AWS Lambda. You can create up to 10 triggers for each CodeCommit repository.

* Triggers are commonly configured to:

* Send emails to subscribed users every time someone pushes to the repository.

* Notify an external build system to start a build after someone pushes to the main branch of the repository

# Create a Trigger in AWS CodeCommit for an Existing AWS Lambda FunctionHeader anchor link

- In this step you will create a trigger in CodeCommit which invokes a Lambda function when a branch or tag is created.

- Open the CodeCommit  console

- In Repositories, choose the gitflow-workshop repository where you want to create triggers for repository events.

- In the navigation pane for the gitflow-workshop repository, choose Settings, and then choose Triggers.

- Choose Create trigger. In Create trigger, do the following:

  In Trigger name, enter a name for the trigger (for example, CreateBranch).
  In Events, choose the repository events that trigger the Lambda function: Create branch or tag.
  In Branches, leave the selection blank, because this default option applies the trigger to all branches automatically.
  In Choose the service to use, choose AWS Lambda. In Lambda function, choose the function name from the list, or enter the ARN for the function.

  ![Screenshot-26.png]
  ![Screenshot-27.png]

  # Develop Branch

    # Create Develop Branch

* When using the git-flow extension library, executing git flow init on an existing repo will create the develop branch:

    1. Initialize gitflow

          ![Screenshot-28.png]
         
    2. List the current branches. The current branch will be highlighted in green and marked with an asterisk.

          ![Screenshot-29.png]

         
    3. git push -u origin develop
         
          ![Screenshot-30.png]


    # Create Development Environment

* After pushing the commits to development branch, the lambda function you created earlier will automatically detect a new develop branch created and codecommit will trigger the function to create the development environment and code pipeline.

* Your new stack, gitflow-workshop-develop, appears in the list at the top portion of the Cloudformation console . Once the cloudformation successfully created the stack go to AWS Elastic Beanstalk Environment Management Console .

- aws cloudformation create-stack --template-body file://envcreate.yaml --parameters file://parameters-dev.json --capabilities CAPABILITY_IAM --stack-name gitflow-workshop-develop

  ![Screenshot-31.png]
  ![Screenshot-32.png]
  ![Screenshot-36.png]


# Feature Branch

  # Feature Branches

     * Each new feature should reside in its own branch, which can be pushed to the central repository for backup/collaboration. But, instead of branching off of master, feature branches use develop as their parent branch. When a feature is complete, it gets merged back into develop. Features should never interact directly with master.

* The idea is to create a pipeline per branch. Each pipeline has a lifecycle that is tied to the branch. When a new, short-lived branch is created, we create the pipeline and required resources. After the short-lived branch is merged into develop, we clean up the pipeline and resources to avoid recurring costs.

# Create Feature Branch Environment

   # Create feature branch
The name of the feature is up to you, choose something simple and short, describing what you are doing. For this workshop we are going to change color by simply editing index.html file. To start a feature named change-color you’ll use:

  - git flow feature start change-color

This will automatically do the following:

create a new branch named feature/change-color from the develop branch,
checkout the feature/change-color branch So, yes, you’re ready to go! Just hack, commit, push, . . . You’ This action performs the following:
And you should see something similar to:

- Switched to a new branch 'feature/change-color' 

Create feature branch environment
The lambda function you created earlier will automatically detect a new branch it will trigger the function to create the environment and code pipeline.

# Commit a change and then update your app

In this step, you will revise the sample code and commit the change to your repository. CodePipeline will detect your updated sample code and then automatically initiate AWS CodeBuild to build the source code. CodePipeline then uses Elastic Beanstalk to deploy the build output to the environment.

Edit line:38 in index.html. We are going to change the color from purple to green

 ![Screenshot-33.png]
 ![Screenshot-34.png]
 ![Screenshot-35.png]
 ![Screenshot-36.png]


# Develop branch
   
   ![Screenshot-37.png]

# Feature branch

 ![Screenshot-38.png]

# Feature Finish

   # Step 1: Finish feature developmentHeader anchor link

* Once you have verified the changes you made and is ready to merge to develop branch.Finish the development of a feature by executing:

   -  git flow feature finish change-color.

# Cleanup

   ![Screenshot-39.png]
   ![Screenshot-40.png]

    
