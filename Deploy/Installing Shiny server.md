Installing Shiny server on Virtual Machine
This markdown document details how to install Shiny Server Pro on a Linux OS (RedHat or Ubuntu) 
Please note the official website : https://www.rstudio.com/products/shiny/download-server/

Installing Shiny Server Pro on RedHat ( v > 7.0, 64bit)
Quick installation
Upload 'install_shiny.sh' and 'shiny-server.conf' in the home directory of your VM and run:

sudo bash install_shiny.sh

Solution #2: Step by step installation is detailed below

System requirements
RedHat v > 7.0, 64bits You can for exmaple use the Red Hat Enterprise Linux 7.2 image from Microsoft Azure's marketplace.
Networking
Virtual machine network configuration
Make sure that the VM has the port 80 open, to be able to access Shiny Server from a web browser. On Microsoft's Azure portal, you have to:

select your virtual machine
go to Network Interfaces
select the NI associated to your VM
go to "Network security group"
Add one Inbound and one Outbound rule, with source port to 80 and destination one to 80
Shiny configuration
Change access port of SSP to 80 in "/etc/shiny-server/shiny-server.conf"
Restart the server: sudo systemctl restart shiny-server
You can know access SSP via the VM's URL in your browser

Installation
Add the EPEL repository
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
rpm -ivh epel-release-7-8.noarch.rpm
Install R
sudo yum -y install R
Install R package Shiny
sudo su - \
-c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
Download Shiny Server Pro
wget https://s3.amazonaws.com/rstudio-shiny-server-pro-build/centos6.3/x86_64/shiny-server-commercial-1.5.1.760-rh6-x86_64.rpm
Install Shiny Server Pro
sudo yum -y install --nogpgcheck shiny-server-commercial-1.5.1.760-rh6-x86_64.rpm


Administrator guide
You can consult the Shiny Server administration guide here

External links
Administrator guide
tutorial resources

Download / installation instructions of SSP on RStudio website
How to enable EPEL repository on Red Hat Enterprise

Installing Shiny Server Pro on Ubuntu 14.04
set up VM env
To install R, we're going to use the APT tool. It uses a special file that lists the sources of where packages should be downloaded from. That file is /etc/apt/sources.list. In order to get the most recent version of R, we need to add the correct repository to the list of sources by adding a line to the sources file. The exact line you need to add will vary depending on the exact Ubuntu version. For Ubuntu 14.04, run the following command to add the correct repository to /etc/apt/sources.list.

sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'

If you directly launch apt-get you will encounter an issue : `W: GPG error: http://cran.rstudio.com trusty/ Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9```

To authenticate packages downloaded using APT, we have to add a public key. The Ubuntu archives on CRAN are signed with a key with ID E084DAB9. Add this key to your system.

gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9   gpg -a --export E084DAB9 | sudo apt-key add -```

Now, we need to update the list of available packages since we updated the sources list sudo apt-get update

Installing R
sudo apt-get -y install r-base

Installing Shiny
Use sudo command to install packages as root and make them available for all users. sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\""

Installing shiny server
(check on RStudio website last release available)

$ sudo apt-get install gdebi-core
$ wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
$ sudo gdebi shiny-server-1.5.3.838-amd64.deb

opening port
Shiny Server by default listens to port 3838 so you will need to open this port on your VM to access apps.

Go to your Azure portal, select your VM and go to Setting >>Network Interfaces


![VM setting](C:/Users/syick/Desktop/VM-shiny-server-group-security.png)


click group security

create a new inboud rule to open port 3838 (listen by default by shiny servers)

test your shiny server :
Open your server : http://[IP]:3838/

DONE You're ready to deploy your apps !
