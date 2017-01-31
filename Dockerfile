FROM fedora:24

RUN ln -sf /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime && \
    dnf -y update && dnf -y install git nginx && dnf clean all

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN git clone https://github.com/letsencrypt/letsencrypt && cd letsencrypt && ./letsencrypt-auto --help

RUN mkdir -p /var/www/letsencrypt /var/www/html

COPY nginx.conf   /etc/nginx/
COPY default.conf /etc/nginx/conf.d/
COPY index.html /var/www/html/
COPY 404.html /var/www/html/
COPY make-certs.sh /

CMD ["nginx", "-g", "daemon off;"]

