<?php

/**
 *
 * Enable captcha for site
 *
 */
$config['use_captcha'] = false;

/**
 *
 * What type of captcha?
 *
 * 'recaptcha'  = Google Recaptcha v2
 * 'recaptcha3' = Google Recaptcha v3
 * 'inbuilt'    = inbuilt captcha system
 *
 */
$config['captcha_type'] = 'inbuilt';

/**
 *
 * After how many tries should a captcha pop up?
 *
 */
$config['captcha_attemps'] = 3;

/**
 *
 * After how many tries should we block an IP address?
 * How many minutes should an IP address remain blocked?
 *
 */
$config['block_attemps'] = 0;
$config['block_duration'] = 0;

// Set block_attemps or block_duration to 0 to disable IP blocking.

/**
 *
 * The site key
 * get site key @ www.google.com/recaptcha/admin
 *
 */
$config['recaptcha_site_key'] = false;

/**
 *
 * The secret key
 * get secret key @ www.google.com/recaptcha/admin
 *
 */
$config['recaptcha_secret_key'] = false;

// Theme
$config['recaptcha_theme'] = 'dark'; // dark - light
