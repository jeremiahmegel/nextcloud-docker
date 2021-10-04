#!/usr/bin/env sh

# Certain parts borrowed from: https://github.com/nextcloud/docker/blob/master/22/apache/entrypoint.sh

run_as() {
	if [ "$(id -u)" = 0 ]; then
		su -p www-data -s /bin/sh -c "$1"
	else
		sh -c "$1"
	fi
}

if [ "$NEXTCLOUD_INSTALLED" = 'true' ]; then
	run_as 'php occ maintenance:update:htaccess'
	run_as 'php occ maintenance:update:protect-data-directory'
fi

exec "$@"
