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
    ROOT_DIR="$SCRIPT_DIR/../"
    CONF_DIR="$ROOT_DIR/conf"
    ENV_DIR="$ENV_DIR/env"

    source "$SCRIPT_DIR/util/env-vars.sh" container

        # PROXY to lower case
    if [ "${PROXY,,}" == "true" ]
    then
        log "Configuring \e[3m$CONTAINER_NAME\e[0m With Upstream Server at \e[3m$PROXY_HOST:$PROXY_PORT\e[0m" $SCRIPT_NAME
        cp "$CONF_DIR/nginx.proxy.conf" "$CONF_DIR/nginx.conf"
    else
        log "Configuring \e[3m$CONTAINER_NAME\e[0m In Standalone Mode" $SCRIPT_NAME
        cp "$CONF_DIR/nginx.standalone.conf" "$CONF_DIR/nginx.conf"
    fi

    log 'Cleaning Docker' $SCRIPT_NAME
    clean_docker

    log "Checking If \e[3m$CONTAINER_NAME\e[0m Container Is Currently Running" $SCRIPT_NAME
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]
    then
        log "Stopping \e[3m$CONTAINER_NAME\e[0m Container" $SCRIPT_NAME
        docker container stop $CONTAINER_NAME

        log "Removing \e[3m$CONTAINER_NAME\e[0m Container" $SCRIPT_NAME
        docker rm $CONTAINER_NAME
    fi

    log "Building \e[3m$IMAGE_NAME:$IMAGE_TAG\e[0m Image" $SCRIPT_NAME
    docker build -t $IMAGE_NAME:$IMAGE_TAG $ROOT_DIR

    for arg in "$@"
    do
        if [ "$arg" == "-d" ] || [ "$arg" == "--detached" ]
        then
            log "Starting Up Container \e[3m$CONTAINER_NAME\e[0m In Detached Mode" $SCRIPT_NAME
            docker run --detached \ 
                        --name $CONTAINER_NAME \ 
                        --publish $NGINX_PORT:$NGINX_PORT \ 
                        --env-file $ENV_DIR/container.env \ 
                        $IMAGE_NAME:$IMAGE_TAG
            exit 0
        fi
    done

    log "Starting Up Container \e[3m$CONTAINER_NAME\e[0m In Foreground" $SCRIPT_NAME
    docker run --name $CONTAINER_NAME \ 
                --publish $NGINX_PORT:$NGINX_PORT \ 
                --env-file $ENV_DIR/container.env \ 
                $IMAGE_NAME:$IMAGE_TAG
fi