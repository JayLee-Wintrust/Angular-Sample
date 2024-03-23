# Angular-Sample

Base images of Node and NGINX are from RedHat:

https://catalog.redhat.com/software/containers/search

--

If you want to use the images from Docker Hub:

https://hub.docker.com/

Then, the Dockerfile would be something like:

FROM docker.io/node:lts as node-builder

