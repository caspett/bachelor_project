FROM ubuntu:20.04
ENV TZ=Europe/Oslo
WORKDIR /home/ubuntu/web-bookface
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install net-tools
RUN apt-get install apache2 libapache2-mod-php php-mysql php-pdo-mysql -y
# RUN git clone https://git.cs.oslomet.no/kyrre.begnum/bookface.git
RUN rm /var/www/html/index.html
# ADD code/* /var/www/html/
# ADD index-heavy.php /var/www/html/index.php
ADD index-combined.php /var/www/html/index.php
ADD BaltimoreCyberTrustRoot.crt.pem /var/www/html/BaltimoreCyberTrustRoot.crt.pem
# ONBUILD ADD ./var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
