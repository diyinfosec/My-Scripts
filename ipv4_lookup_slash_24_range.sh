#!/bin/bash

#- Author: Ramprasad Ramshankar 
#- Alias: diyinfosec
#- Date: 10-Dec-2018
#- Purpose: To read an IP address and do host lookups for the /24 subnet.
#- Language:  bash script

#- Input: IP Address
echo "Enter IP address to scan"
read ip_addr

#- Getting the first 3 octets of the IP address
mod_ip=$(echo $ip_addr | cut -f1-3 -d"." )

#- Looping over last octets from 1 to 254
#- Last octet with .0 will be the network address and .255 will be the broadcast address
#- https://searchitchannel.techtarget.com/tip/Assigning-an-IP-address-ending-in-0-or-255
END=254
var1=$(for ((i=1;i<=END;i++)); do
	ip_to_resolve=$mod_ip"."$i
	#- Run the host command to perform a reverse lookup
	host $ip_to_resolve | awk '{print $NF}'
done) 

echo $var1 | tr ' ' '\n' | uniq -u | less
