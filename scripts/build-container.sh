SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-container'
nl=$'\n'
SCRIPT_DES="Options: \n \n     --help/-h : Print This Help Message ${nl}${nl}\
     --detached/-d : Start Container In Background"
source "$SCRIPT_DIR/util/logging.sh"


if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else
    source $SCRIPT_DIR/util/env-vars.sh container
        # reset SCRIPT_DIR because sourcing overwrites it
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

        # WRAPPER to lower case
    if [ "${PROXY,,}" == "true" ]
    then
        log "Configuring \e[3m$CONTAINER_NAME\e[0m With Upstream Server at \e[3m$PROXY_HOST:$PROXY_PORT\e[0m" $SCRIPT_NAME
        cp $SCRIPT_DIR/../conf/nginx.proxy.conf $SCRIPT_DIR/../conf/nginx.conf
    else
        log "Configuring \e[3m$CONTAINER_NAME\e[0m In Standalone Mode" $SCRIPT_NAME
        cp $SCRIPT_DIR/../conf/nginx.standalone.conf $SCRIPT_DIR/../conf/nginx.conf
    fi

    log 'Clearing Docker Cache' $SCRIPT_NAME
    docker system prune -f

    log 'Deleting Dangling Images' $SCRIPT_NAME
    docker rmi -f $(docker images --filter "dangling=true" -q)

    log "Checking If \e[3m$CONTAINER_NAME\e[0m Container Is Currently Running" $SCRIPT_NAME
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]
    then
        log "Stopping \e[3m$CONTAINER_NAME\e[0m Container" $SCRIPT_NAME
        docker container stop $CONTAINER_NAME

        log "Removing \e[3m$CONTAINER_NAME\e[0m Container" $SCRIPT_NAME
        docker rm $CONTAINER_NAME
    fi

    log "Building \e[3m$IMAGE_NAME:$IMAGE_TAG\e[0m Image" $SCRIPT_NAME
    docker build -t $IMAGE_NAME:$IMAGE_TAG $SCRIPT_DIR/../

    for arg in "$@"
    do
        if [ "$arg" == "-d" ] || [ "$arg" == "--detached" ]
        then
            log "Starting Up Container \e[3m$CONTAINER_NAME\e[0m In Detached Mode" $SCRIPT_NAME
            docker run -d --name $CONTAINER_NAME -p $NGINX_PORT:$NGINX_PORT --env-file $SCRIPT_DIR/../env/container.env $IMAGE_NAME:$IMAGE_TAG
            exit 0
        fi
    done

    log "Starting Up Container \e[3m$CONTAINER_NAME\e[0m In Foreground" $SCRIPT_NAME
    docker run --name $CONTAINER_NAME -p $NGINX_PORT:$NGINX_PORT --env-file $SCRIPT_DIR/../env/container.env $IMAGE_NAME:$IMAGE_TAG
fi