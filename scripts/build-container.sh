SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-container'
nl=$'\n'
tab='     '
SCRIPT_DES="Options: ${nl}${tab}--help/-h : Print This Help Message ${nl}\
${tab}--detached/-d : Start Container In Background"
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

        # PROXY to lower case
    if [ "${PROXY,,}" == "true" ]
    then
        log "Configuring \e[3m$CONTAINER_NAME\e[0m with upstream server at \e[3m$PROXY_HOST:$PROXY_PORT\e[0m" $SCRIPT_NAME
        cp "$CONF_DIR/nginx.proxy.conf" "$CONF_DIR/nginx.conf"
    else
        log "Configuring \e[3m$CONTAINER_NAME\e[0m in standalone mode" "$SCRIPT_NAME"
        cp "$CONF_DIR/nginx.standalone.conf" "$CONF_DIR/nginx.conf"
    fi

    log 'Cleaning Docker' "$SCRIPT_NAME"
    clean_docker

    log "Checking if \e[3m$CONTAINER_NAME\e[0m container is currently running" "$SCRIPT_NAME"
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]
    then
        log "Stopping \e[3m$CONTAINER_NAME\e[0m container" "$SCRIPT_NAME"
        docker container stop "$CONTAINER_NAME"

        log "Removing \e[3m$CONTAINER_NAME\e[0m container" "$SCRIPT_NAME"
        docker rm "$CONTAINER_NAME"
    fi

    log "Building \e[3m$IMAGE_NAME:$IMAGE_TAG\e[0m Image" "$SCRIPT_NAME"
    docker build -t "$IMAGE_NAME:$IMAGE_TAG" "$PROJECT_DIR"

    log "Application image built. Invoke \e[3mrun-container\e[0m to start application server." "$SCRIPT_NAME"
fi