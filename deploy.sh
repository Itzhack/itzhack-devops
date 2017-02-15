#!/bin/bash
## Assuming service's files are updated ##
# Parameters
status=0
#Usage
function ShowUsage () {
	cat <<End_of_usage_msg
Usage: $0 [-s <service name>| -a ]
  --help - display this message
  -s <servie name> (e.g counter-panda or gify-panda)
  -a deploy both services
End_of_usage_msg
}

#Functions
function parseArgs () {
	while (( "$#" ))
	do
		echo $1
		case "$1" in
		-s*)	service=$2
				break;;
		-a)  	service="counter-panda gify-panda"
				break;;
		*)    	ShowUsage && exit 1;;
		esac
		shift
	done
}

function check_status () {
	if [ $1 != 0 ] ; then "ERROR: $2" ; exit $1 ;fi
}

# MAIN #
if [ -z $1 ];then ShowUsage && exit 1 ;fi
parseArgs $*
echo Deploying $service ...
for s in "$service" ; do
  /usr/bin/ansible-playbook ./deploy.yml --extra-var=$s
  check_status $? "while Deploying $s"
done
