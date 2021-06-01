myname="mohit"
s3_bucket="upgrad-mohit"

#Update the packages
echo "***********************Updating the packages************************"
sudo apt update -y

############################# To check if apache is already installed or not #############################
dpkg -s apache2

if [ $? -eq 0 ]
then
        echo "*****************************Apache2 Server is Installed -> CHECKED*******************************"
else
        echo "***********************Installing Apache2 Server***************************"
        sudo apt-get install apache2 -y
fi

####################################### To check if APACHE is RUNNING or not ###############################
service apache2 status

if [ $? -eq 0 ]
then
        echo "**********************************Apache is running -> CHECKED******************************"
else
        echo "**********************************WAIT Running Apache*************************"
        service apache2 start
fi

################################################ To check of APACHE is ENABLED ################################
systemctl list-unit-files |  grep enabled | grep apache2

if [ $? -eq 0 ]
then
        echo "*******************************Apache is ENABLED -> CHECKED********************************"
else
        echo "*******************************Running Apache****************************"
        sudo systemctl enable apache2
fi
##############################################################################################################

#Creatng tar of logs file in temp folder and pushing it in S3
echo "********************************Creating Timestamp and making tar file********************"
timestamp=$( (date '+%d%m%Y-%H%M%S') )
tar -zcvf /tmp/$myname-httpd-logs-$timestamp.tar  --exclude=other_vhosts_access.log   /var/log/apache2/*.log
#taking tar size
tar_size=$( (du -k /tmp/${myname}-httpd-logs-${timestamp}.tar | cut -f1) )
echo "**************************Pushing Tar to upgrad-Mohit S3 Bucket**************************"
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
