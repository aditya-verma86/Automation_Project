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

# Extract string formatted for inventory table
string=$(du -h adityaverma-httpd-logs-$timestamp.tar)
substr=$(echo $string | cut -c1-4)

mv adityaverma-httpd-logs-$timestamp.tar ./tmp/

# Check if inventory.html exists else create file with headers
FILE=/var/www/html/inventory.html
if [ -f "$FILE" ]
then
	echo "<br>httpd-logs&emsp;&emsp;$timestamp&emsp;&emsp;tar&emsp;&emsp;${substr}" >> /var/www/html/inventory.html

else	
	echo "Log Type&emsp;&emsp;Date Created&emsp;&emsp;Type&emsp;&emsp;Size" >> /var/www/html/inventory.html
      	echo "<br>httpd-logs&emsp;&emsp;$timestamp&emsp;&emsp;tar&emsp;&emsp;${substr}" >> /var/www/html/inventory.html
fi

# Create bucket
aws s3 mb s3://${s3_bucket}

# Upload tar file into s3 bucket
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar

FILE=automation
if [ -f "$FILE" ]
then 
	# do nothing
else
echo "0 0 * * * root /root/Automation_Project/automation.sh" >> /etc/cron.d/automation
fi
