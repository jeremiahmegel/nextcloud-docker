<?php
require 'version.php';

$CONFIG = [
	'installed' => getenv('NEXTCLOUD_INSTALLED') === 'true',
	'version' => implode('.', $OC_Version),
	'instanceid' => getenv('NEXTCLOUD_INSTANCE_ID'),
	'trusted_domains' => explode(' ', getenv('NEXTCLOUD_TRUSTED_DOMAINS')),
	'passwordsalt' => getenv('NEXTCLOUD_PASSWORD_SALT'),
	'secret' => getenv('NEXTCLOUD_SECRET'),
	'overwrite.cli.url' => getenv('NEXTCLOUD_BASE_URL'),
	'encryption.legacy_format_support' => false,
	'default_phone_region' => 'US'
];

if (getenv('POSTGRES_DB')) {
	$CONFIG['dbtype'] = 'pgsql';
	$CONFIG['dbhost'] = getenv('POSTGRES_HOST');
	$CONFIG['dbuser'] = getenv('POSTGRES_USER');
	$CONFIG['dbpassword'] = getenv('POSTGRES_PASSWORD');
	$CONFIG['dbname'] = getenv('POSTGRES_DB');
}
