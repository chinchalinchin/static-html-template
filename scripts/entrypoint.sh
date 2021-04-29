SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='bootstrap'
nl=$'\n'
SCRIPT_DES=""
source "$SCRIPT_DIR/util/sys-util.sh"


if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
elif [ $# -eq 0 ]
then
    log "Default Application Entrypoint" $SCRIPT_NAME

    log "Substituting Environment Variables In \e[3mnginx.conf\e[0m" $SCRIPT_NAME
    SUB_STR='$NGINX_PORT,$ROOT_DIR,$PROXY_HOST,$PROXY_PORT'
    envsubst $SUB_STR < /etc/nginx/nginx.conf | sponge /etc/nginx/nginx.conf

    log "Logging \e[3mnginx\e[0m Configuration" $SCRIPT_NAME
    cat /etc/nginx/nginx.conf
    echo "${nl}"

    log "Starting \e[3mnginx\e[0m Server..." $SCRIPT_NAME
    log "Server Started. Vist \e[3mlocalhost:$NGINX_PORT\e[0m to Access \e[7mnginx-angular-starter\e[0m Splash Page." $SCRIPT_NAME
    nginx -g "daemon off;"
fi
