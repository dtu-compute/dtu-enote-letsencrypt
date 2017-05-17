#!/bin/sh

echo "Creating certificates with URL suffix domain ${domain}"

echo
echo

ls /etc/letsencrypt

if [ -d /etc/letsencrypt/live/${domain} ]; then
    echo "Cert already exists; use update-certs.sh to renew"
    exit 1  
fi

echo "  ./letsencrypt-auto --agree-tos --email mttj@dtu.dk --non-interactive certonly --expand --webroot -w /var/www/letsencrypt -d $domain"
./letsencrypt-auto --agree-tos --email mttj@dtu.dk --non-interactive certonly --expand --webroot -w /var/www/letsencrypt -d $domain
