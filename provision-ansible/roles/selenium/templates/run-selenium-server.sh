#!/bin/bash

case "$(uname -s)" in
   Darwin)
     echo 'Detected OS: MacOSX'
     PATH="/Users/$(whoami)/node_modules/phantomjs/bin:$PATH" 
     nohup java -jar {{ selenium_filename }} > ./selenium-server.log 2>&1 &
     echo 'Starting: Selenium Server'
     ;;

   Linux)
     echo 'Detected OS: Debian based'
     PATH="$(pwd)/node_modules/phantomjs/bin:$PATH"
     nohup java -jar {{ selenium_filename }} > ./selenium-server.log 2>&1 &
     echo 'Starting: Selenium Server'
     ;;

   *)
     echo 'Detected unknown OS: Not supported.'
     echo 'Supported OS: Debian based  and MacOSX only.' 
     ;;
esac