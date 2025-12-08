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

if ! which ddev > /dev/null; then
  echo "ddev is required. Install from homebrew"
  exit 1
fi

output_dir="$1"
template_dir="$(pwd)/$(dirname "$0")/templates"
set -e

if [ -d "$output_dir" ]; then
  echo "Output directory $output_dir already exists"
  exit 1
fi

mkdir -p "$output_dir"
cd "$output_dir"

ddev config --project-type=drupal --docroot=web
ddev start
ddev composer create-project drupal/cms

echo
echo "======================================================================"
echo
echo "Copying config files"
echo
echo "======================================================================"
echo
cp "${template_dir}"/apt.yml .
cp "${template_dir}"/gitignore .gitignore
cp "${template_dir}"/init.sh .
cp "${template_dir}"/settings*.php web/sites/default/
mkdir -p .bp-config/php/php.ini.d
cp "${template_dir}"/bp-config/options.json .bp-config/
cp "${template_dir}"/bp-config/*.ini .bp-config/php/php.ini.d/
cp -r "${template_dir}"/scripts .
cp -r "${template_dir}"/terraform .


echo
echo "======================================================================"
echo
echo "Files copied"
echo
echo "======================================================================"
echo

chmod +x init.sh

echo
echo "======================================================================"
echo
echo "Adding s3fs"
echo
echo "======================================================================"
echo
ddev composer require drupal/s3fs

echo
echo "======================================================================"
echo
echo "Now run ./init.sh"
echo
echo "======================================================================"
echo

exec ddev ssh
