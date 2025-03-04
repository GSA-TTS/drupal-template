#! /bin/bash

if [ "$CF_INSTANCE_INDEX" != 0 ]; then
  echo "Not on first instance, not running post-deploy script"
  exit 0
fi

update_drupal() {
  echo  "Updating drupal..."
  drush state:set system.maintenance_mode 1 -y
  drush deploy -y
  drush state:set system.maintenance_mode 0 -y
  # echo "Importing translations..."
  # drush locale:import-all /home/vcap/app/web/modules/weather_i18n/translations
  # drush locale:clear-status
  # drush locale:update
  echo "Rebuilding cache..."
  drush cache:clear drush -y
  drush cache:rebuild
  echo "post-deploy finished"
}

install_drupal() {
  echo "Installing drupal site..."
  SECRETS=$(echo "$VCAP_SERVICES" | jq --arg name "$SECRETS_INSTANCE_NAME" '.["user-provided"][] | select(.name == $name) | .credentials')
  ROOT_USER_NAME=$(echo "$SECRETS" | jq -r '.ROOT_USER_NAME')
  ROOT_USER_PASS=$(echo "$SECRETS" | jq -r '.ROOT_USER_PASS')

  : "${ROOT_USER_NAME:?Need and root user name for Drupal}"
  : "${ROOT_USER_PASS:?Need and root user pass for Drupal}"

  SITE_RECIPE="${SITE_RECIPE:-minimal}"

  drush site:install $SITE_RECIPE \
      --no-interaction \
      --account-name="$ROOT_USER_NAME" \
      --account-pass="$ROOT_USER_PASS" \
      --existing-config
}

echo "Checking if installed..."
if drush list | grep "config:import" > /dev/null; then
  update_drupal &
else
  install_drupal &
fi
echo "Returning from post-deploy"
