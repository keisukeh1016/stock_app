FROM nginx:1.19.0

RUN apt update -y \
      && apt install -y certbot python-certbot-nginx

RUN rm -f /etc/nginx/conf.d/default.conf
COPY rails.conf /etc/nginx/conf.d/

COPY letsencrypt.sh /stock_app/
RUN chmod 777 /stock_app/letsencrypt.sh

EXPOSE 80 443