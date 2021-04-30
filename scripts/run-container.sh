SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-container'
nl=$'\n'
tab='     '
SCRIPT_DES="Launchs the application image on the NGINX_PORT configured in \
\e[3m.env\e[0m file ${nl}${nl}.Options: ${nl}${tab}--help/-h : Print this help message ${nl}\
${tab}--detached/-d : Start container in background"
source "$SCRIPT_DIR/util/sys-util.sh"


if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else
    PROJECT_DIR="$SCRIPT_DIR/../"
    CONF_DIR="$PROJECT_DIR/conf"
    ENV_DIR="$PROJECT_DIR/env"

    source "$SCRIPT_DIR/util/env-vars.sh"

    for arg in "$@"
    do
        if [ "$arg" == "-d" ] || [ "$arg" == "--detached" ]
        then
            log "Starting Up Container \e[3m$CONTAINER_NAME\e[0m In Detached Mode" "$SCRIPT_NAME"
            docker run --detached \
                        --name "$CONTAINER_NAME" \
                        --publish "$NGINX_PORT:$NGINX_PORT" \
                        --env-file "$ENV_DIR/.env" \
                        "$IMAGE_NAME:$IMAGE_TAG"
            exit 0
        fi
    done

    log "Starting Up Container \e[3m$CONTAINER_NAME\e[0m In Foreground" "$SCRIPT_NAME"
    docker run --name "$CONTAINER_NAME" \
                --publish "$NGINX_PORT:$NGINX_PORT" \
                --env-file "$ENV_DIR/.env" \
                "$IMAGE_NAME:$IMAGE_TAG"
fi