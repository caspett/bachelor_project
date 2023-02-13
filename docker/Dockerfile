FROM ubuntu:20.04
ENV TZ=Europe/Oslo
WORKDIR /home/ubuntu/web-bookface
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install net-tools
RUN apt-get install apache2 libapache2-mod-php php-pgsql -y
# RUN git clone https://git.cs.oslomet.no/kyrre.begnum/bookface.git
RUN rm /var/www/html/index.html
ADD code/* /var/www/html/
# ONBUILD ADD ./var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
