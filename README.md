# Static HTML Angular App

An nginx container configured to serve an Angular 11 app that renders an arbitrary number of static HTML documents in the <i>/frontend/src/assets/</i> and adds navigable links to each document in a collapsible <b>Angular Material</b> drawer menu based on the name given to the document in the <i>/frontend/src/assets/conf.json</i> configuration file. 

## Quickstart

### Prerequisites

- [NodeJS]()
- [Docker]()

### Local

Install the <i>node_modules</i> dependencies,

`cd /frontend/`<br>
`npm install -g @angular/cli`<br>
`npm install`

1. Development Mode

`ng serve`

2. Production Mode

Build Angular webpacks, start/reload nginx with <i>/conf/nginx.conf</i>

`ng build --prod --output-hashing none`<br>
`nginx -c ./conf/nginx.conf -s start/reload`

### Container

Copy <i>.sample.env</i> into <i>.env</i>

`cp .sample.env .env`

See <i>.sample.env</i> environment file comments for more information on each environment variable. Then copy the static HTML sample configuration file into a new configuration file,

`cp /frontend/src/assets/conf.sample.json /frontend/src/assets/conf.json`

Copy in the static HTML documents you want rendered and add them to the <i>conf.json</i> accordingly. See example included in sample file. 

Once the application image context is configured (i.e. what you just did), invoke the <i>build-container.sh</i> shell script to build a Docker image. From the root directory,

> ./scripts/build-container.sh

This will build a multi-stage Docker image, perform an Angular production build, copy the artifacts into an <b>nginx</b> container and then bring up the <b>nginx</b> server on <i>localhost:8080</i>. You can adjust the port the server runs on by changing the <b>NGINX_PORT</b> environment variable in the <i>.env</i> file.

## Proxy 

If you have a backend server running, enable the <b>PROXY</b> environment variable to tell nginx to proxy requests to the backend on the <i>/api/</i> route. Be sure to configure the <b>PROXY_HOST</b> and <b>PROXY_PORT</b> variables accordingly. See <i>.sample.env</i> comments for more information.

If <b>PROXY</b> is set to <i>true</i>, the <i>/conf/nginx.proxy.conf/</i> is used when running the application image. If <b>PROXY</b> is set to <i>false</i>, then <i>/conf/nginx.standalone.conf/</i> is used to configure the application image. This switch occurs on line 22-29 of the <i>build-container</i> script, i.e. before invoking `docker build`, the <b>image context</b> is prepared and configured for the selected mode.

## Static HTML Templates

In the <i>/frontend/src/assets/</i> folder you will find the static html that is rendered within the Angular app's interface. There is a <i>conf.json</i> in this directory the Angular app uses to configure the static html navigation and appearance on the drawer menu. You can add or remove static html templates from this folder; if you do so, make sure to adjust the <i>config.json</i> accordingly. 

By default, 

## Documentation

This app is its own documentation. Start it up and visit <i>localhost:8080</i> to give it a whirl.

# Notes

1. If you get the following error when startig up the container `$'\r': command not found`, this is due to the line endings in the either the <i>/scripts/bootstrap.sh</i> or <i>/scripts/util/logging.sh</i> shell script. Use the <b>unixify</b> function in the <i>/scripts/util/sys-util.sh</i> shell script to traverse the project directory and change all line endings to Unix-style, 

> ./scripts/util/sys-util.sh unixify "$(pwd)"

I recommend deleting the <i>/frontend/node_modules/</i> directory before doing this, as the traversal will take some time if <i>node_modules</i> is included in its search path.