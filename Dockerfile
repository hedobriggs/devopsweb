FROM nginx:alpine

RUN apk update && apk upgrade

WORKDIR usr/share/nginx/html

COPY . .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
