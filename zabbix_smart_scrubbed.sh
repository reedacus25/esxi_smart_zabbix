#!/bin/bash

#set zabbix server/proxy info
zabbixServer=$zabbixServerOrProxy
zabbixName=$zabbixMonitoredHostName

for device in $(ssh root@$yourESXiHost esxcli storage core device list | grep "^t10.NVMe") ;
        do
                #Health Status
                healthStatus=$(ssh root@$yourESXiHost esxcli storage core device smart get -d $device | grep "Health Status" | awk '{print $3}')
                zabbixKey=$org.esxi.smart.$device.health
                zabbixValue=$healthStatus
                /usr/bin/zabbix_sender -vv -z "$zabbixServer" -s "$zabbixName" -k "$zabbixKey" -o "$zabbixValue"

                #Reallocated Sectors
                reallocatedSectors=$(ssh root@$yourESXiHost esxcli storage core device smart get -d $device | grep "Reallocated Sector Count" | awk '{print $4}')
                zabbixKey=$org.esxi.smart.$device.reallocated
                zabbixValue=$reallocatedSectors
                /usr/bin/zabbix_sender -vv -z "$zabbixServer" -s "$zabbixName" -k "$zabbixKey" -o "$zabbixValue"

                #Drive Temperature
                driveTemp=$(ssh root@$yourESXiHost esxcli storage core device smart get -d $device | grep "Drive Temperature" | awk '{print $3}')
                zabbixKey=$org.esxi.smart.$device.drive_temp
                zabbixValue=$driveTemp
                /usr/bin/zabbix_sender -vv -z "$zabbixServer" -s "$zabbixName" -k "$zabbixKey" -o "$zabbixValue"

        done

for device in $(ssh root@$yourESXiHost esxcli storage core device list | grep "^naa") ;
        do
                #Health Status
                healthStatus=$(ssh root@$yourESXiHost esxcli storage core device smart get -d $device | grep "Health Status" | awk '{print $3}')
                zabbixKey=$org.esxi.smart.$device.health
                zabbixValue=$healthStatus
                /usr/bin/zabbix_sender -vv -z "$zabbixServer" -s "$zabbixName" -k "$zabbixKey" -o "$zabbixValue"

                #Write Error Count
                writeErrors=$(ssh root@$yourESXiHost esxcli storage core device smart get -d $device | grep "Write Error Count" | awk '{print $4}')
                zabbixKey=$org.esxi.smart.$device.write_errors
                zabbixValue=$writeErrors
                /usr/bin/zabbix_sender -vv -z "$zabbixServer" -s "$zabbixName" -k "$zabbixKey" -o "$zabbixValue"

                #Read Error Count
                readErrors=$(ssh root@$yourESXiHost esxcli storage core device smart get -d $device | grep "Read Error Count" | awk '{print $4}')
                zabbixKey=$org.esxi.smart.$device.read_errors
                zabbixValue=$readErrors
                /usr/bin/zabbix_sender -vv -z "$zabbixServer" -s "$zabbixName" -k "$zabbixKey" -o "$zabbixValue"

                #Drive Temperature
                driveTemp=$(ssh root@$yourESXiHost esxcli storage core device smart get -d $device | grep "Drive Temperature" | awk '{print $3}')
                zabbixKey=$org.esxi.smart.$device.drive_temp
                zabbixValue=$driveTemp
                /usr/bin/zabbix_sender -vv -z "$zabbixServer" -s "$zabbixName" -k "$zabbixKey" -o "$zabbixValue"

        done