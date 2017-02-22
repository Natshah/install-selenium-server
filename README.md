## Install Selenium Server

Installing and configuring selenium server for automated testing sessions.

Some time I do test using some internal or external selenium servers, but they
do not have the option of restarting every thing from the beginning.

I just want to have a very fast and basic solution, so that when the automated functional test session finishes, then the 
selenium server restart, and gave me a fresh start for the next automated
testing session.
 
I made this list of scripts with a basic installer which:
- Have Selenium standalone server, It will be downloaded and installed on your localhost or server.
- Then selenium will start working after reboots.
- This selenium server will start at the 4445 port number.
- We can contrule and change the version from the config.yml file

```
## Selenium server configurations.
version: 3.1.0
major_version: 3
minor_version: 1
patch_version: 0
port: 4445
```


You will need to have Java first.
================================================================================
```
$ sudo apt-get install openjdk-8-jdk
$ sudo apt-get install openjdk-8-jre
```
================================================================================

Run the following command to install selenium server:
================================================================================
```
$  sh ./install-selenium-server.sh
```
================================================================================


We could use the following commands to control the server
================================================================================
```
sudo /etc/init.d/selenium start
```

```
sudo /etc/init.d/selenium stop
```

```
sudo /etc/init.d/selenium restart
```
================================================================================


If you want to Uninstall :
================================================================================
```
$  sh ./uninstall-selenium-server.sh
```
================================================================================

Then Reboot.

The only thing we do need is a reset Button to restart the selenium server to 
work in a new automated testing session.

If you want to change the port number, you could do that by editing the config.yml server config file:

```
$ sudo vim /etc/selenium/config.yml
$ sudo /etc/init.d/selenium restart
```

