# Automation_Project
Automating apache server creation in AWS EC2 instance and compressing the logs file and pushing it in attached S3 bucket with an IAM role for it.
First we create a EC2 instance an IAM role attached to it and SG group associated to it and a S3 bucket in which IAM role is attached with an access of "AmazonS3fullaccess".

Once the EC2 is up connect it through terminal and write a bash script that will 
->check for latest updates
->then to check if the machine is having apache2 server installed in it or not,if not install it.
-> check if it server running or not, if not run it
-> check if the apache2 is enabled in the daemon part and run whenever machine reboot, if not enable it.

Now to analyze anything we need to have logs for the machine activity.
So inroder to collect logs automation.sh will be 
-> checking the logs folder in the root and creating a tar file for the logs present there and pushing it to /tmp folder in root
-> now copying this log tar folder to our S3 bucket storage where we can analyze the logs.
-> we will create a inventory.html fle in our /var/www/html folder where we will note down the logs transfer activities.
-> each time we run the script and a tar is created it will be added as a new line data entry in inventory.html file which we can check in the browser.


Now to make this automation.sh script run by itself we will be wrtting a cron job in it, which will create a cron job named automation in /etc/cron.d folder in root 
That will make the automation.sh script run once in a day to do all the above pointed activity by its own.

Conclusion:By doing this we are automating our logs analysis activity of a paticular EC2 instance by storing its logs in S3 bucket and making it run on daily basis by cron and automation.sh script

