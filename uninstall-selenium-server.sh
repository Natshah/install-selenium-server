#!/bin/bash

if [ -d "/usr/lib/selenium" ]; then

  # Stop selenium server.
  sudo /etc/init.d/selenium stop
  sudo rm -rf /usr/lib/selenium
  echo "\nDeleted selenium.\n"

  # Delete selenium server logs.
  sudo rm -rf /var/log/selenium
  echo "Deleted logs.\n"

  # Remove selenium server configurations.
  if [ -d "/etc/selenium" ]; then
    sudo rm -rf /etc/selenium
    echo "Removed selenium server configurations.\n"
  fi

  sudo update-rc.d -f selenium remove
  echo "Removed selenium server.\n"
else
  echo "You can not uninstall, Selenium is NOT installed."
fi