# WordPress-Website-Using-LAMP-Stack
**Automated WordPress Installer for LAMP Stack on Ubuntu**

A bash script to automate the installation of a complete LAMP stack
(Linux, Apache, MySQL, PHP) and download the latest version of WordPress
on an Ubuntu server. This script streamlines the setup process, but
requires some manual configuration to finalize the installation.

**► Features**

-   ✅ **Installs Apache2:** The world\'s most popular web server.

-   ✅ **Installs MySQL Server:** A robust and reliable database for
    your WordPress site.

-   ✅ **Installs PHP 7.3:** Including all necessary modules required by
    WordPress.

-   ✅ **Downloads WordPress:** Fetches the latest stable version of
    WordPress directly from wordpress.org.

-   ✅ **Sets Permissions:** Configures the correct file permissions for
    the WordPress directory.

**► Prerequisites**

Before you begin, ensure you have the following:

-   An Ubuntu server (tested on Ubuntu 18.04/20.04).

-   sudo or root privileges.

-   Access to the command line / SSH.

**► How to Use**

Follow these simple steps to get your server ready for WordPress.

**Step 1: Clone the Repository or Download the Script**

First, get the script onto your server.

\# Clone the repository
```bash
git clone
https://github.com/Sidhant8591/WordPress-Website-Using-LAMP-Stack.git
```
```bash
cd your-repo-name
```
 Or download the script directly
```bash
wget
https://github.com/Sidhant8591/WordPress-Website-Using-LAMP-Stack.git
```
**Step 2: Make the Script Executable**

You need to give the script permission to run.
```bash
chmod +x WordPress-lamp.sh
```
**Step 3: Run the Script**

Execute the script with sudo privileges.
```bash
sudo ./WordPress-lamp.sh
```
or
```bash
bash wordPress-Lamp.sh
```
The script will now install Apache, MySQL, and PHP. **Pay close
attention to the terminal**, as you will be prompted for input during
the MySQL secure installation.

**⚠️ Important: Manual Configuration Required!**

This script automates the installation of the software, but for security
and site-specific setup, you **must** complete the following steps
manually.

**1. Secure Your MySQL Installation**

The script will trigger the mysql_secure_installation process. You will
be asked to:

-   Set a root password for MySQL.

-   Remove anonymous users.

-   Disallow root login remotely.

-   Remove the test database.

-   Reload privilege tables.

It is highly recommended that you answer \'Y\' (yes) to all prompts.

**2. Create the WordPress Database & User**

Log in to MySQL with the root password you just created.
```bash
sudo mysql -u root -p
```
Now, run the following commands to create a database and a dedicated
user for WordPress. **Remember to replace MyStrongPass123! with your own
secure password.**
```bash
CREATE DATABASE wordpress_db;

CREATE USER \'wordpress_user\'@\'localhost\' IDENTIFIED BY
\'MyStrongPass123!\';

GRANT ALL PRIVILEGES ON wordpress_db.\* TO
\'wordpress_user\'@\'localhost\';

FLUSH PRIVILEGES;

exit;
```
**3. Configure wp-config.php**

The script downloads WordPress into /var/www/html/wordpress. Navigate to
this directory and edit the configuration file.
```bash
cd /var/www/html/wordpress

sudo mv wp-config-sample.php wp-config.php

sudo nano wp-config.php
```
Update the database details with the information from the previous step:
```bash
define(\'DB_NAME\', \'wordpress_db\');

define(\'DB_USER\', \'wordpress_user\');

define(\'DB_PASSWORD\', \'MyStrongPass123!\'); // \<\-- Use your new
password here

define(\'DB_HOST\', \'localhost\');
```
Save and close the file (CTRL+X, then Y, then Enter).

**4. Set Up Apache Virtual Host (Optional, but Recommended)**

To host your site on a custom domain (e.g., example.com), you should
create a virtual host file.
```bash
sudo nano /etc/apache2/sites-available/your-domain.com.conf
```
Add the following configuration, replacing your-domain.com with your
actual domain name.
```bash
\<VirtualHost \*:80\>

ServerName your-domain.com

ServerAlias \[www.your-domain.com\](https://www.your-domain.com)

DocumentRoot /var/www/html/wordpress

ErrorLog \${APACHE_LOG_DIR}/error.log

CustomLog \${APACHE_LOG_DIR}/access.log combined

\</VirtualHost\>
```
Enable the new site and restart Apache:
```bash
sudo a2ensite your-domain.com.conf

sudo systemctl restart apache2
````
**► Finalizing the Installation**

You are now ready! Open your web browser and navigate to your server\'s
IP address or your domain name. You will be greeted by the famous
WordPress five-minute installation wizard.

Follow the on-screen instructions to set up your site title,
administrator account, and password.

**Congratulations! You have successfully installed WordPress on a LAMP
stack.**

**► License**

This project is licensed under the MIT License. See the
[[LICENSE]{.underline}](https://www.google.com/search?q=LICENSE) file
for details.

