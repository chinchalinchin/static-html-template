SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='bootstrap'
nl=$'\n'
SCRIPT_DES=""
source "$SCRIPT_DIR/util/logging.sh"


if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else

    log "Substituting Environment Variables In \e[3mnginx.conf\e[0m" $SCRIPT_NAME
    envsubst '$NGINX_PORT,$PROXY_HOST,$PROXY_PORT' < /etc/nginx/nginx.conf | sponge /etc/nginx/nginx.conf

    log "Logging \e[3mnginx\e[0m Configuration" $SCRIPT_NAME
    cat /etc/nginx/nginx.conf
    echo "${nl}"

    log "Starting \e[3mnginx\e[0m Server..." $SCRIPT_NAME
    log "Server Started. Vist \e[3mlocalhost:$NGINX_PORT\e[0m to Access \e[7mnginx-angular-starter\e[0m Splash Page." $SCRIPT_NAME
    nginx -g "daemon off;"
fi
