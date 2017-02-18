#!/bin/bash

# Parse yaml configurations.
parse_yaml_config() {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

if [ ! -d "/usr/lib/selenium" ]; then

  # Save the selenium configuration file.
  if [ ! -d "/etc/selenium" ]; then
    sudo mkdir /etc/selenium
    sudo chmod 755 /etc/selenium
    sudo cp config.yml /etc/selenium/config.yml
  else
    sudo cp config.yml /etc/selenium/config.yml
  fi

  # Read the etc selenium configuration file.
  eval $(parse_yaml_config /etc/selenium/config.yml "config_")

  sudo mkdir /usr/lib/selenium
  echo "Created selenium directory in /usr/lib.\n"

  echo "Getting selenium server standalone $config_version\n"
  sudo wget http://selenium-release.storage.googleapis.com/$config_major_version.$config_minor_version/selenium-server-standalone-$config_major_version.$config_minor_version.$config_major_version.$config_patch_version.jar
  sudo mv selenium-server-standalone-$config_major_version.$config_minor_version.$config_patch_version.jar /usr/lib/selenium/selenium-server-standalone-$config_major_version.$config_minor_version.$config_patch_version.jar
  sudo ln -s /usr/lib/selenium/selenium-server-standalone-$config_major_version.$config_minor_version.$config_patch_version.jar /usr/lib/selenium/selenium-server-standalone.jar
  echo "The selenium server standalone is ready in the server.\n"



  sudo mkdir -p /var/log/selenium
  sudo chmod a+w /var/log/selenium
  echo "Created the logs for selenium.\n"

  sudo cp selenium.sh /etc/init.d/selenium
  sudo chmod 755 /etc/init.d/selenium
  sudo update-rc.d selenium defaults $config_port
  echo "Installed selenium server.\n"
  sudo /etc/init.d/selenium start

else
  echo "Selenium is installed.\nIf you want to update or install you will need:\n to run ./uninstall-selenium-server.sh first"
fi
