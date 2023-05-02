
### TASK -9: Static website with S3 and CloudFront

### S3 website endpoint

  ** http://vedad-varupa-devops-mentorship-program-week-11.s3-website-us-east-1.amazonaws.com

### Distribution.net endpoint

  **  https://d1dyt3sid4gos.cloudfront.net

### R53 record

  **  https://www.vedad-varupa.awsbosnia.com/


### 1. Created `website` directory and added custom `index.html`, `error.html` and `devOps-img.png` files. 

### 2. Created S3 bucket `vedad-varupa-devops-mentorship-program-week-11` in eu-east-1 and uploaded previously created files for static website.   Enabled public access, enabled bucket versioning and enabled static website hosting option.

### 3. Configured bucket policy in order to allow public access to all S3 bucket objects. 

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::vedad-varupa-devops-mentorship-program-week-11/*"
        }
    ]
}

### 4. S3 bucket website endpoint: 

** http://vedad-varupa-devops-mentorship-program-week-11.s3-website-us-east-1.amazonaws.com

### 5. Before creating CloudFront distribution, we need to generate Amazon SSL certificate using AWS Certificate

 bash command:  
 ** aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch 
 '{"Changes":
     [{"Action":"CREATE",
           "ResourceRecordSet":{
            "Name":"_c7675f235eb510845e9b048079f01b21.www.vedad-varupa.awsbosnia.com.",
            "Type":"CNAME",
             "TTL":60,
             "ResourceRecords":[{"Value":"_3a25526c1dc8e1c0918459a5a93b3869.tctzzymbbs.acm-validations.aws."}]
     }}]
 }' --profile aws-bosnia**

### 6. Created CloudFront distribution with Origin domain that points to S3 bucket website endpoint to S3 bucket website endpoint: 
    - http://vedad-varupa-devops-mentorship-program-week-11.s3-website-us-east-1.amazonaws.com
    - Name - vedad-varupa-devops-mentorship-program-eu-east-1.amazonaws.com
    - Origin access - `public`
    - Default root object - `index.html`
    - Viewer protocol policy -  `(Redirect HTTP to HTTPS)`
    - Settings - `Custom SSL certificate` 

### 7. Created DNS CNAME record

** aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch 
'{"Changes":
[{"Action":"CREATE",
"ResourceRecordSet":{
    "Name":"www.vedad-varupa.awsbosnia.com",
    "Type":"CNAME",
    "TTL":60,
    "ResourceRecords":[{"Value":"d1dyt3sid4gos.cloudfront.net"}]
  }}]
}'
  
### 8. Verify that DNS CNAME record 

**  aws route53 list-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK | jq '.ResourceRecordSets[] | select(.Name == "vedad-varupa.awsbosnia.com.") | {Name, Value}'




