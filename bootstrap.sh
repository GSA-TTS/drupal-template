#!/usr/bin/env bash

usage="
  $0: Create a new cloud.gov-enabled drupal/cms app

Usage:
  $0 APP_DIR
"

if [ $# -lt 1 ]; then
  echo "$usage"
  exit 1;
fi

if ! which composer > /dev/null; then
  echo "composer is required. Install from homebrew"
  exit 1
fi

if ! which ddev > /dev/null; then
  echo "ddev is required. Install from homebrew"
  exit 1
fi

output_dir="$1"
set -e

composer create-project drupal/cms "$output_dir"

echo
echo "======================================================================"
echo
echo "Copying config files"
echo
echo "======================================================================"
echo
cp templates/apt.yml "$output_dir"
cp templates/gitignore "$output_dir"/.gitignore
cp templates/init.sh "$output_dir"
cp templates/settings*.php "$output_dir"/web/sites/default/
mkdir -p "$output_dir"/.bp-config/php/php.ini.d
cp templates/bp-config/options.json "$output_dir"/.bp-config/
cp templates/bp-config/*.ini "$output_dir"/.bp-config/php/php.ini.d/
cp -r templates/scripts "$output_dir"
cp -r templates/terraform "$output_dir"


echo
echo "======================================================================"
echo
echo "Files copied"
echo
echo "======================================================================"
echo

cd "$output_dir"
chmod +x init.sh

echo
echo "======================================================================"
echo
echo "Adding s3fs"
echo
echo "======================================================================"
echo
composer require drupal/s3fs

echo
echo "======================================================================"
echo
echo "Now run ./init.sh"
echo
echo "======================================================================"
echo

ddev config --project-type=drupal --docroot=web
ddev start
ddev ssh
