<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', 'wordpress');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'B[|U#(}VkI9h,N@[WMZq]l.-<n|SSdN9Av4c]>b,@m{eKy}]IgW`WNLRGrZ9b^ |');
define('SECURE_AUTH_KEY',  'HmnQDPU0hhLg`i}6zr!`V>0pGEV0Yb.M_X E@s+(=NDSjgVDd~,5SpPkAs|geh|4');
define('LOGGED_IN_KEY',    'tQC*]5I;6;Y%@3d<hEEU4H)1PrM4_h+e0hY9l|(tUv?3sr^/-|0ehWA-MwFp_*|3');
define('NONCE_KEY',        '^sx>v<8.;2Anz.7,Ee&hRNzg>y?8!D3mc}X->x;eMo+Rt&jWnkr` *ovKta|+e+=');
define('AUTH_SALT',        '!OP?.-Jd1p^DKdnp[Du]d);%`MAX<eJUiXR#+xRi.V>; myZB9 fVcYX2$FLUx(K');
define('SECURE_AUTH_SALT', 'M2[TC7MHBH3MSh~d4p-VP`JBN_)t+4qx2Hr<F~606,UFtTuZ?K66[l4?+dg.-UF1');
define('LOGGED_IN_SALT',   '@;C?R1v[*=)ui7GP!</s|b)0VJVzotuktyxGe$zkih5FuO{Q+J(G+yD,gJW|n<c]');
define('NONCE_SALT',       'n.->~Wf5pR(&}?7Oj3E?$D;S@K6q VPxL/W|29>LyfxXa7[mE4|H5JfB9cZEASp]');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);


define( 'MULTISITE', true );
define( 'SUBDOMAIN_INSTALL', false );
$base = '/';
define( 'DOMAIN_CURRENT_SITE', 'blogdev.webmd.com' );
define( 'PATH_CURRENT_SITE', '/' );
define( 'SITE_ID_CURRENT_SITE', 1 );
define( 'BLOG_ID_CURRENT_SITE', 1 );

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
