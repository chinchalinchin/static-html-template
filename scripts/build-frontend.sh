SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_NAME='build-frontend'
nl=$'\n'
SCRIPT_DES=""
source "$SCRIPT_DIR/util/sys-util.sh"


if [ "$1" == "--help" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "-h" ]
then
    help "$SCRIPT_DES" $SCRIPT_NAME
    exit 0
else
    source $SCRIPT_DIR/util/env-vars.sh local
        # reset SCRIPT_DIR because sourcing overwrites it
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    FRONTEND_DIR=$SCRIPT_DIR/../frontend

    cd $FRONTEND_DIR

    log "Installing \e[3mAngular\e[0m CLI v$ANGULAR_VERSION" $SCRIPT_NAME
    npm install -g @angular/cli@$ANGULAR_VERSION

    log "Installing \e[3mAngular\e[0m Dependencies" $SCRIPT_NAME
    npm install
    
    log "Compiling \e[3mAngular\e[0m Artifacts In \e[4m/build/\e[0m Directory"
    ng build --configuration=$ANGULAR_CONFIG --output-hashing none
fi