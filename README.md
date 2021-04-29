# nginx-angular-starter

An nginx container configured to serve Angular 11 and proxy requests to the a backend container.

## Quickstart

Copy <i>.sample.env</i> into <i>container.env</i>

> cp .sample.env container.env

Invoke <i>build-container.sh</i> shell script. From the root directory,

> ./scripts/build-container.sh

This will bring up an <b>nginx</b> server on <i>localhost:8080</i>. You can adjust the port the server runs on by changing the <b>NGINX_PORT</b> environment variable in the <i>container.env</i> file.

If you have the wrapper server running, enable the <b>PROXY</b> variable to tell nginx to proxy requests to the backend. Be sure to configure the <b>PROXY_HOST</b> and <b>PROXY_PORT</b> variables accordingly. See <i>.sample.env</i> comments for more information.

## Static HTML Templates

In the <i>/frontend/src/assets/</i> folder you will find the static html that is rendered within the Angular app's interface. There is a <i>config.json</i> in this directory the Angular app uses to configure the static html navigation and appearance on the drawer menu. You can add or remove static html templates from this folder; if you do so, make sure to adjust the <i>config.json</i> accordingly. 

# Notes

1. If you get the following error when startig up the container `$'\r': command not found`, this is due to the line endings in the either the <i>/scripts/bootstrap.sh</i> or <i>/scripts/util/logging.sh</i> shell script. Use the <i>/scripts/util/unixify.sh</i> shell script to traverse the project directory and change all line endings to Unix-style, 

> ./scripts/util/unixify.sh "$(pwd)"

I recommend deleting the <i>/frontend/node_modules/</i> directory before doing this, as the traversal will take some time if <i>node_modules</i> is included in its search path.