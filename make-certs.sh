#!/bin/sh

if [ $# -ne 2 ]; then
    # TODO: print usage
    echo "Usage: make-certs.sh <url-suffix> <course;course;course>"
    exit 1
fi

url_suffix=$1
courses=($(echo $2 | tr "," "\n"))

alldomains=( `./ls-certs.sh $*` )

echo "Creating/Renewing certificates with URL suffix ${url_suffix} domains ${alldomains[@]}"

echo
echo

cd /letsencrypt

for d in ${alldomains[@]}
do
  echo $d
  echo "  ./letsencrypt-auto --agree-tos --email mttj@dtu.dk --non-interactive certonly --expand --webroot -w /var/www/letsencrypt -d $d"
  ./letsencrypt-auto --agree-tos --email mttj@dtu.dk --non-interactive certonly --expand --webroot -w /var/www/letsencrypt -d $d
done
