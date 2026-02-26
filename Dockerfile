FROM nginx:alpine

WORKDIR usr/status/nginx/html

COPY . .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
