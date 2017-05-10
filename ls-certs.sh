#!/bin/bash

CONFIG_ROOT=${DTU_DATA_ROOT}
: ${CONFIG_ROOT:="/vol"}
export CONFIG_ROOT=$CONFIG_ROOT

if [ -n "$1" ]
then
  url_suffix=$1
else
  url_suffix=`source 'get-hostnames.sh'`
fi

if [ -n "$2" ]
then
  courses=($(echo $2 | tr "," "\n"))
else
  courses=($(grep -E "^'?[0-9]{5}" ${CONFIG_ROOT}/config/courses.yaml | tr -d "':"))
fi


coursewebs=$(for i in ${courses[*]}; do printf "${i}${url_suffix} "; done)
courseenotewebs=$(for i in ${courses[*]}; do printf "${i}-enote${url_suffix} "; done)
coursesharelatexes=$(for i in ${courses[*]}; do printf "sharelatex-${i}${url_suffix} "; done)
coursenoteesharelatexes=$(for i in ${courses[*]}; do printf "sharelatex-${i}-enote${url_suffix} "; done)

domains=( "enote$url_suffix" "quiz$url_suffix" "letsencrypt$url_suffix" )

alldomains=( "${domains[@]}" "${coursewebs[@]}" "${courseaskbots[@]}" "${coursesharelatexes[@]}" )

course_arg=`IFS=',';echo "${courses[*]// /}";IFS=$' \t\n'`
for d in ${alldomains[@]}
do
  echo $d
done
