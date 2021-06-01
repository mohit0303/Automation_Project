myname="mohit"
s3_bucket="upgrad-mohit"

#Update the packages
echo "Updating the packages.."
sudo apt update -y

#To check if apache is already installed or not
dpkg -s apache2

#install apache if not already installed
if [ $? -eq 0 ]
then
	echo "Apache2 server is installed."
else
	echo "Installing Apache2 Server..."
	sudo apt-get install apache2 -y
fi
#to check if APACHE is RUNNING if installed
#service apache2 status
#if [ $? -eq 0 ]
#then
#	echo "Apache is running!"
#else
#	echo "Running Apache.."
#	service apache2 restart
#fi
#to check of APACHE is ENABLED

#Creatng tar of logs file in temp folder and pushing it in S3

timestamp=$( (date '+%d%m%Y-%H%M%S') )
echo "$timestamp"
tar -zcvf /tmp/$myname-httpd-logs-$timestamp.tar  --exclude=other_vhosts_access.log   /var/log/apache2/*.log
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
