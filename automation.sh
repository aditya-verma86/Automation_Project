# Course Assignment

# Set variable
s3_bucket=s3-bucket-aditya
myname=adityaverma

# Install aws cli
sudo apt-get install awscli

# Update packages
sudo apt update -y

# Install apache2 server
sudo apt-get install apache2

# Check if services are enabled and running
sudo systemctl status apache2

# Create tar file of *.log files and move the temp folder
timestamp=$(date '+%d%m%Y-%H%M%S')
tar -cvf adityaverma-httpd-logs-$timestamp.tar ./var/log/apache2/*.log
mv adityaverma-httpd-logs-$timestamp.tar ./tmp/

# Create bucket
aws s3 mb s3://${s3_bucket}

# Upload tar file into s3 bucket
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
