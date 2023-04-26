
#### Commands used in this task: ####

#### Creating AWS profile

    ```
    aws configure
    ```
#### Creating DNS record 

   aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{
           "Changes":[{"Action":"CREATE",
           "ResourceRecordSet":
                    {"Name":"vedad-varupa.awsbosnia.com.",
                     "Type":"A","TTL":60,
                      "ResourceRecords":[{"Value":"54.227.56.154"}]}}]
    }'

#### Checking DNS records

    aws route53 list-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK | jq '.ResourceRecordSets[] | select(.Name == "vedad-varupa.awsbosnia.com.") | {Name, Value}'

#### Creating Let's Encrypt certificate on server and add autorenewal cron job

    ```
    sudo dnf install python3 augeas-libs
    sudo python3 -m venv /opt/certbot/
    sudo /opt/certbot/bin/pip install --upgrade pip
    sudo /opt/certbot/bin/pip install certbot certbot-nginx
    sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
    sudo certbot certonly --nginx 
    echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo tee -a /etc/crontab > /dev/null
    ```

#### Imported Lets Encrypt SSL certificate inside AWS Certified Manager

#### Load balancer created

#### Created a new SSL certificate within the AWS Certified Manager

#### Created AMI image ami-ec2-vedad-varupa-task-8
