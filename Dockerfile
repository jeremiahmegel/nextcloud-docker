# Modified from: https://github.com/nextcloud/docker/blob/master/.examples/dockerfiles/cron/apache/Dockerfile

ARG NEXTCLOUD_VERSION

FROM nextcloud:$NEXTCLOUD_VERSION-apache

# https://docs.digitalocean.com/products/app-platform/build-system/dockerfile-build/#limitations
RUN test -e /var/run || ln -s /run /var/run

RUN apt-get update && \
	apt-get install -y supervisor && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir /var/log/supervisord /var/run/supervisord

RUN curl -fsSL "https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD_VERSION.tar.bz2" | tar -C /usr/src/nextcloud -xj nextcloud/updater --strip-components 1

RUN ["mv", "/usr/src/nextcloud", "/var/www/nextcloud"]
WORKDIR /var/www/nextcloud/
RUN ["chown", "-R", "www-data:root", "."]
RUN ["sed", "-i", "s/\\/var\\/www\\/html/\\/var\\/www\\/nextcloud/g", "/etc/apache2/sites-available/000-default.conf", "/var/spool/cron/crontabs/www-data"]

COPY config.php config/
RUN ["chown", "www-data:root", "config/config.php"]

COPY supervisord.conf /

ENV NEXTCLOUD_DATA_DIR /var/www/nextcloud/data
RUN ["touch", "data/.ocdata"]

ENTRYPOINT []
CMD ["supervisord", "-c", "/supervisord.conf"]
