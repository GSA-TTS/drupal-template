#!/usr/bin/env bash

# initialize a new drupal site with s3fs for cloud.gov use
# this file only needs to be run a single time and can be deleted afterwards

set -e

drush site:install minimal -y
drush recipe $(pwd)/recipes/drupal_cms_starter -y
drush pm:install s3fs -y
drush config:set system.file default_scheme s3 -y
drush config:set field.storage.media.field_media_document settings.uri_scheme private -y
drush config:set field.storage.media.field_media_image settings.uri_scheme private -y
drush config:set field.storage.media.field_media_svg_image settings.uri_scheme private -y
drush config:export -y
head -n -12 web/sites/default/settings.php > settings.php && mv settings.php web/sites/default/settings.php
