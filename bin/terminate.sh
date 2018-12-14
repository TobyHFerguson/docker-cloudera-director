. $(dirname $0)/.director-client.sh

terminate() { client ${FUNCNAME[0]} ${1:?'No conf file provided'} ;}

terminate $1
