##Install the Apache web server
sudo apt-get install apache2 -y

#Start and enable Apache to start automatically upon server reboot
sudo systemctl start apache2
sudo systemctl enable apache2

#Check Apache server is up and running
systemctl status apache2

##Install the MySQL Database server
sudo apt-get install mysql-server -y

#In order to improve the security of your MySQL server run the mysql_secure_installation script
sudo mysql_secure_installation

#Enable it to automatically start upon boot
sudo systemctl start mysql
sudo systemctl enable mysql

##Install PHP
#Add the php7 ppa
sudo add-apt-repository ppa:ondrej/php

#Update the system
sudo apt-get update

#Do a search to confirm php7
sudo apt search php7


#Install PHP  including some additional modules
sudo apt-get install php7.3 libapache2-mod-php7.3 php7.3-mysql php7.3-curl php7.3-mbstring php7.3-gd php7.3-xml php7.3-xmlrpc php7.3-intl php7.3-soap php7.3-zip

#Check all the PHP modules available in Ubuntu
apt-cache search --names-only ^php

#Test if PHP is working properly place a file called info.php inside  Apache web server root directory (/var/www/html/)
sudo nano /var/www/html/info.php

#Enter the following content inside the file and save it

###############
# <?php       #
# phpinfo();  #
# ?>          #
###############

#Restart the Apache server
sudo systemctl restart apache2

#Visit page: http://your_server_ip_address/info.php or http://localhost/info.php

##Install WordPress
#download and place the WordPress in the default web server document root directory (/var/www/html)
cd /var/www/html
sudo wget -c http://wordpress.org/latest.tar.gz

#Extract the file
sudo tar -xzvf latest.tar.gz

#Set the correct permissions of wordpress directory
sudo chown -R www-data:www-data /var/www/html/wordpress

#Login to MySQL server 
sudo mysql -u root -p

#Create a new database for our WordPress installation
CREATE DATABASE wordpress_db;

#Grant Privileges to DB user

#####################################################################################################
# CREATE DATABASE wordpress_db;                                                                     #
# CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY 'MyStrongPass123!';                        #
# GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'localhost';                           #
# FLUSH PRIVILEGES;                                                                                 #
# exit;                                                                                             #
#####################################################################################################

#Rename the sample configuration file to wp-config.php
cd /var/www/html/wordpress
sudo mv wp-config-sample.php wp-config.php

#Open the wp-config.php
sudo nano wp-config.php

#Update the database settings with database details

#The name of the database for WordPress, database username,database password,hostname,Charset as follows
########################################
# define('DB_NAME', 'wordpress_db');   #
# define('DB_USER', 'wordpress_user'); #
# define('DB_PASSWORD', 'MyStrongPass123!');   #
# define('DB_HOST', 'localhost');      #
# define('DB_CHARSET', 'utf8');        #
########################################

#Save and exit the file

#Restart your Apache and MySQL server
sudo systemctl restart apache2
sudo systemctl restart mysql

#Apache Virtual Host Set Up

#Create the virtual host configuration file(Replace mydomain.com with actual domain name)
sudo nano /etc/apache2/sites-available/mydomain.com.conf

#Add the following content to the file (Replace mydomain.com with actual domain name)

#################################################################
# <VirtualHost *:80>
#
# ServerAdmin admin@mydomain.com
# ServerName mydomain.com
# ServerAlias www.mydomain.com
# DocumentRoot /var/www/html/wordpress
#
# ErrorLog ${APACHE_LOG_DIR}/mydomain.com_error.log
# CustomLog ${APACHE_LOG_DIR}/mydomain.com_access.log combined
#
# </VirtualHost>         
#######################################################################

#Also need to configure hosts file to use a local customize domain name

#Enable the virtual host
sudo a2ensite mydomain.com.conf

# restart the Apache web server
sudo systemctl restart apache2
