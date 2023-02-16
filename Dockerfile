FROM nginx:alpine-slim
WORKDIR /opt/hello-2048
COPY ./public_html/ /usr/share/nginx/html
