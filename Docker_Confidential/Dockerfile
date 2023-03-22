FROM php:8.1.17-apache

ENV TZ=Europe/Oslo
WORKDIR /home/ubuntu/web-bookface
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install net-tools
RUN rm /var/www/html/index.html
ADD index-combined.php /var/www/html/index.php
ADD BaltimoreCyberTrustRoot.crt.pem /var/www/html/BaltimoreCyberTrustRoot.crt.pem
EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]