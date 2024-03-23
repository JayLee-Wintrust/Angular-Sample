ARG PACKAGE_JSON_NAME=angular-sample


FROM registry.access.redhat.com/ubi9/nodejs-20:1-34 as node-builder
WORKDIR /usr/src/app
COPY --chown=1001:1001 package*.json ./
#TODO: mount Wintrust CA certs
RUN npm config set strict-ssl false
RUN npm ci
COPY --chown=1001:1001 tsconfig*.json ./
COPY --chown=1001:1001 angular*.json ./
COPY --chown=1001:1001 src src
RUN npm run build



FROM registry.access.redhat.com/ubi9/nginx-122:1-59
ARG PACKAGE_JSON_NAME
COPY --from=node-builder --chown=1001:1001 /usr/src/app/dist/${PACKAGE_JSON_NAME} ${NGINX_APP_ROOT}/src 
CMD nginx -g "daemon off;"
