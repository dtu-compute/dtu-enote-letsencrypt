#!/bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: make-certs.sh <url-suffix> <course;course;course>"
    exit 1
fi

url_suffix=$1
courses=($(echo $2 | tr "," "\n"))

alldomains=( `./ls-certs.sh $*` )

echo "Creating certificates with URL suffix ${url_suffix} domains ${alldomains[@]}"

echo
echo

cd /letsencrypt

for d in ${alldomains[@]}
do
  if [ ! -d /etc/letsencrypt/live/${d} ]; then
    echo "certificate folder for ${d} exist! skipping.  Use update-certs.sh to create."
    continue
  fi
  echo $d
  echo "  ./letsencrypt-auto --agree-tos --email mttj@dtu.dk --non-interactive certonly --expand --webroot -w /var/www/letsencrypt -d $d"
  ./letsencrypt-auto --agree-tos --email mttj@dtu.dk --non-interactive certonly --expand --webroot -w /var/www/letsencrypt -d $d
done
