# ANGULAR BUILD
FROM node:latest as angular
ENV NODE_VERSION=14
ENV ANGULAR_VERSION=11

# DEPENDENCIES
RUN apt-get update -y && apt-get install -y curl moreutils && \ 
    npm install -g @angular/cli@${ANGULAR_VERSION} \
    && mkdir /home/build/ && mkdir /home/frontend/

COPY /frontend/ /home/frontend/
WORKDIR /home/frontend/

# --prod: Configured to output /home/build/
RUN ng build --prod --output-hashing none

# PRODUCTION SERVER
FROM nginx:latest

# DEPENDENCIES && CONFIGURATION
RUN apt-get update -y && apt-get install -y curl moreutils && \
    useradd -ms /bin/bash chinchalinchin && groupadd admin && \
    usermod -a -G admin chinchalinchin  && mkdir /home/build/ && \
    mkdir /home/frontend/ && mkdir /home/scripts

# COPY ARTIFACTS, CONFIGURATION AND SHELL SCRIPTS INTO IMAGE
COPY --chown=chinchalinchin:admin --from=angular /home/build/ /home/build/
COPY --chown=chinchalinchin:admin /conf/nginx.conf /etc/nginx/nginx.conf
COPY --chown=chinchalinchin:admin /conf/mime.types /etc/nginx/mime.types
COPY --chown=chinchalinchin:admin /scripts/entrypoint.sh /home/scripts/entrypoint.sh
COPY --chown=chinchalinchin:admin /scripts/util/logging.sh /home/scripts/util/logging.sh

# PERMISSION CONFIGURATOIN
RUN chown -R chinchalinchin:admin /home/build/ /var/cache/nginx/ /var/run/ /var/log/nginx/ && \ 
    chmod -R 770 /home/build/

# ENTRYPOINT CONFIGURATION
EXPOSE 8080
USER chinchalinchin
ENTRYPOINT [ "bash", "/home/scripts/entrypoint.sh" ]