FROM centos:7

MAINTAINER "Greg Gigon @ https://github.com/greggigon"

ADD apacheds.sh /usr/local/bin/
RUN useradd apacheds

ENV DOWNLOAD_URL=http://mirrors.nav.ro/apache//directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25-x86_64.rpm

RUN yum -y update && yum -y install java-1.7.0-openjdk openldap-clients && curl -s $DOWNLOAD_URL -o /tmp/apacheds.rpm \
	&& yum -y localinstall /tmp/apacheds.rpm && rm -rf /tmp/apacheds.rpm && mkdir -p /bootstrap \
	&& ln -s /var/lib/apacheds-2.0.0.AM25/default/partitions /data && chmod +x /usr/local/bin/apacheds.sh \
	&& chown -R apacheds.apacheds /data && chown -R apacheds.apacheds /var/lib/apacheds-2.0.0.AM25/default/partitions


VOLUME /data
VOLUME /bootstrap

ENTRYPOINT /usr/local/bin/apacheds.sh

EXPOSE 10389
EXPOSE 10636
