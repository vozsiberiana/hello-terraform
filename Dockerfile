FROM nginx:alpine-slim
WORKDIR /home/sinensia/hello-2048
COPY ./public_html/ /usr/share/nginx/html
