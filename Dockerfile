FROM nginx:alpine:3.23.4

WORKDIR usr/share/nginx/html

COPY . .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
