#!/bin/sh

url_suffix='-staging.compute.dtu.dk'
courses=()

if [ -n "$1" ]
then
  url_suffix=$1
fi

if [ -n "$2" ]
then
  courses=$(echo $2 | tr "," "\n")
fi

coursewebs=$(for i in ${courses[*]}; do printf "${i}-enote${url_suffix} "; done)
courseaskbots=$(for i in ${courses[*]}; do printf "askbot-${i}-enote${url_suffix} "; done)
coursesharelatexes=$(for i in ${courses[*]}; do printf "sharelatex-${i}-enote${url_suffix} "; done)

domains=( "stackedit$url_suffix" "couchdb$url_suffix" "enote$url_suffix" "quiz$url_suffix" "letsencrypt$url_suffix" )

alldomains=( "${domains[@]}" "${coursewebs[@]}" "${courseaskbots[@]}" "${coursesharelatexes[@]}" )

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
