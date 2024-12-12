#FROM nginx:latest
#COPY ./kk_etcd_ui/build/web /usr/share/nginx/html/web
#COPY ./kk_etcd_ui/lib/docker/default.conf /etc/nginx/conf.d/default.conf
#EXPOSE 80

FROM jitesoft/lighttpd:latest

COPY ../build/web /var/www/html
EXPOSE 80

