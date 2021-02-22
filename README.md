# nginx-angular-starter

An nginx container configured to serve Angular 11 and proxy requests to the a backend container.

## Quickstart

Copy <i>.sample.env</i> into <i>container.env</i>

> cp .sample.env container.env

Invoke <i>build-container.sh</i> shell script. From the root directory,

> ./scripts/build-container.sh

This will bring up an <b>nginx</b> server on <i>localhost:8080</i>. You can adjust the port the server runs on by changing the <b>NGINX_PORT</b> environment variable in the <i>container.env</i> file.

If you have the wrapper server running, enable the <b>PROXY</b> variable to tell nginx to proxy requests to the backend. Be sure to configure the <b>PROXY_HOST</b> and <b>PROXY_PORT</b> variables accordingly. See <i>.sample.env</i> comments for more information.

# Notes

1. If you get the following error when starting up the container `$'\r': command not found`, this is due to the line endings in the either the <i>/scripts/bootstrap.sh</i> or <i>/scripts/util/logging.sh</i> shell script. Use the <i>/scripts/util/unixify.sh</i> shell script to traverse the project directory and change all line endings to Unix-style, 

> ./scripts/util/unixify.sh "$(pwd)"

I recommend deleting the <i>/frontend/node_modules/</i> directory before doing this, as the traversal will take some time if <i>node_modules</i> is included in its search path.


## nginx Documentation
- [nginx Beginner's Guide](https://nginx.org/en/docs/beginners_guide.html)
- [nginx Docker Hub](https://hub.docker.com/_/nginx)
- [nginx Github](https://github.com/nginxinc/docker-nginx)
- [nginx HTTP Core Module Variables](http://nginx.org/en/docs/http/ngx_http_core_module.html#variables)
- [nginx HTTP Headers Module](http://nginx.org/en/docs/http/ngx_http_headers_module.html)
- [nginx Example Config](https://www.nginx.com/nginx-wiki/build/dirhtml/start/topics/examples/full/)
- [nginx try_files](http://nginx.org/en/docs/http/ngx_http_core_module.html#try_files)

## nginx Tutorials
- [Serve Angular App on nginx Server](https://thatisuday.medium.com/serving-angular-app-on-nginx-server-7656166c2f1c)
- [nginx Font Face Formats](https://serverfault.com/questions/186965/how-can-i-make-nginx-support-font-face-formats-and-allow-access-control-allow-o)
- [nginx Font Rules](https://www.linode.com/community/questions/16980/nginx-font-rules)
- [nginx CORS](https://serverfault.com/questions/162429/how-do-i-add-access-control-allow-origin-in-nginx)


## Stack Overflows
- [Run nginx With Custom Config](https://stackoverflow.com/questions/30151436/how-to-run-nginx-docker-container-with-custom-config)
- [No Events Section in Configuration](https://stackoverflow.com/questions/54481423/nginx-startup-prompt-emerg-no-events-section-in-configuration)