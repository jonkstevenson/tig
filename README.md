# tig

TIG Repo is intended as a quick setup for investigating and using Telegraf / InfluxDB_V2 / Grafana

This Repo should not be considered a production stack, it is provided for the use of investigating and learning about these components quickly
and easily without the need to work through individual installs and configurations of all components. 

There is no black magic, to see how all this is installed simply review the associated terrform code. 


# Environment: 
   Cloud Provider:  AWS
   OS: Ubuntu_Server_22.04_LTS
   Model: t2micro / freetier
   DiskSpace: 20G
   Privs:  root priv required
   
# Note: 
this is all unix based and relies on Ubuntu. if another operating system is desired you will need to review all the terraform and 
make the approriate adjustments.

If you are using a Cloud Provider ensure you have access to your host on ports: ssh/22 , influxdb/8086 , and grafana/3000.

# Requirements:
   The only software required to be on the host prior to running is "git". git is already installed on AWS
   ubuntu images. All remaining requirements will be installed using the repo.
   
# install

   # login to your new aws instance
   #> ssh ubuntu@ec2-xx-xx-xx-xx.us-west-2.compute.amazonaws.com

   # become root once logged in
   ubuntu@ip-172-31-24-177>:  sudo -i 

   # cd to /opt to clone repo
   cd /opt
   
   # clone repository
   git clone https://github.com/jonkstevenson/tig.git
   
   # cd to tig
   cd /opt/tig

   # install terraform 
   ./terraform_setup.sh
   
   # confirm working directory
   /opt/tig

   # install TIG 
   terraform init && terraform validate && terraform apply -auto-approve
   
We are installing with all the defaults which is valid for an AWS EC2 instances. Review the terraform.tfvars files for additional configurations are changes.

Successful deployment results in:

Outputs:

grafana_pwd = "Grafana Password:  xxxxxxxxxx"
grafana_url = "Grafana URL: http://ip-xx-xx-xx-xx:3000"
grafana_user = "Grafana User: admin "
influxdb_pwd = "Influxdb Password:  xxxxxxxx"
influxdb_url = "Influxdb URL: http://ip-xx-xx-xx-xx:8086"
influxdb_user = "Influxdb User: admin"

Note: the internal IP is showing because this is an AWS EC2 instance. To access this remotely use the internal IP if accessible in your environment 
or use a pulbic facing IP such as ec2-xx-xx-xx-xx.us-west-2.compute.amazonaws.com to connect:

You should be able to connect remotely now to Grafana:

Use the grafana admin / password combination outputed.

You should be able to browse dashboards, two dashboards are provided as an example and use the newer FLUX lanquage.
  
http://yourinstance.compute.amazonaws.com:3000

You should be able to connect remotely now to InfluxDB:

http://yourinstance.compute.amazonaws.com:8086

Use the influx admin / password combination outputed.

# Shutdow

If you plan on keeping your TIG stack and just shutdown you instance. The docker containers will NOT automatically restart. You will 
need to do the following:

# Restart Services Containers after System Shutdown
cd /opt/tig/install_tig && docker-compose up -d 

# Stop Services Containers
cd /opt/tig/install_tig && docker-compose down

# Destroy Everything
Simply destroy your ec2 instances and everything is gone.

# Terraform Destroy / Remove Config
cd /opt/tig && terraform destroy -auto-approve

Using terraform to tear down the configuration will only remove the docker compose configuration. Docker and other utilitites installed will remain.

