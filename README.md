##  Monitor your ESXi disks SMART stats

This is a quick and dirty script and template to grab some quick statistics like drive health and temperature, as well as some other values like reallocated sectors and read/write errors.

This template monitors two specific types of disks on an ESXi host, local NVMe disks which are enumerated with the regex `^t10.NVMe` and local SAS disks that are enumerated with the regex `^naa.`
There are separate template files for `t10nvme` and `naaSAS` based on the stats that are exposed for these disks types.

I plan to add support for SATA disks enumerated with `^t10.ATA` in the future, but I wasn't able to test it with my current hardware.

I am using ESXi 6.7 and using Zabbix 5.0.

These scripts require passwordless SSH access to your ESXi host in question, so make sure your ssh public key is loaded onto your ESXi host.

You also need to make sure you have the zabbix_sender package installed.

The way I architected the template file is PER DISK.
So you need to edit/import the template for each disk you are wanting to monitor.
The script will monitor all of the disks in one go.

In scripts and the templates, there are some variable that need to be set.
In the scripts you need to set:
* zabbixServer - this is the hostname or IP address of your Zabbix server or proxy
* zabbixName - this is the name of the host that the template is applied to in Zabbix
* yourESXiHost - this is your ESXi host to which you are SSHing to
* org - this is part of the zabbix key, I made the zabbix key using my org name to make it unique
 

In the template you need to set:
* device - this is the name of the device as listed by ESXi using `esxcli nvme device list`
* org - same as org above


Once you do a find and replace in the template for each device, and in the scripts, you just need to configure these scripts to run automatically, in crontab for instance.

There are two scripts, because one I only run once a day (slow) to monitor model/serial/firmware changes, while I run the other (fast) every hour to monitor wear/temperature/etc. You can set these intervals to whatever makes sense for you.

Hope this is helpful to someone out there.
