#!/bin/bash

if [[ -z "$1" || -z "$2" ]]; then echo "usage: $0 <pcap file> <txt file>"; exit 1; fi
if [ ! -e "$1" ]; then echo "$0: $1: file does not exist"; exit 1; fi
if [ ! -e "$2" ]; then echo "$0: $2: file does not exist"; exit 1; fi

cat /dev/null > output_domains.txt
input_domains="$2"
for domain in $(cat $input_domains)
do
	if [ -z "$domains" ]; then domains="dns.qry.name == $domain";
	else domains="$domains || dns.qry.name == $domain"; fi
done
tshark -r output.pcap -Y "$domains" -T fields -e dns.qry.name | uniq
