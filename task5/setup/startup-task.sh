# TODO: Should we randomize this?
export JUPYTER_PASSWORD=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`
export DIGITS_URL_PREFIX=/`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`
export TENSORBOARD_URL_PREFIX=/`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`

# TODO: Figure this out instead of pulling from envirnment variable
base=/dli/tasks/${TASK_NAME}/setup/
#script="$(readlink -f ${BASH_SOURCE[0]})"
#base="$(dirname $script)"

####Custom 

####

# PARAMs can't be used as the base url, so we do this. Then we save the original one for reference
sed -e "s:/proxydigits:$DIGITS_URL_PREFIX:" ${base}/nginx.orig > ${base}/nginx.run
sed -ie "s:/proxytensorboard:$TENSORBOARD_URL_PREFIX:" ${base}/nginx.run

/usr/bin/supervisord -c ${base}/supervisor.task
 
