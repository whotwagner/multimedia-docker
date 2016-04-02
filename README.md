# Docker-Container for skype and spotify

This project contains a dockerfile for building a multimedia-image. This image is
based on ubuntu trusty and has google-chrome, skype, firefox, vivaldi and spotify pre-installed.
One could use this docker-image to keep his system clean from closed-source software by
seperating it using a container. Of course it is possible to run all those applications at once


## Requirements:

- pulseaudio running on the host
- X11 running on the host

## Building the image:

./run_mm.sh build

## Using the image:
### run spotify
./run_mm.sh spotify

### run skype
./run_mm.sh skype 

### run a shell
./run_mm.sh bash

### run firefox
./run_mm.sh firefox

### run vivaldi
./run_mm.sh vivaldi

It is possible to run the applications using the same container

Making changes permanent:
-------------------------
The configuration-files for spotify and skype are persistent. This is realized with mounted volumes in $HOME/.mymultimediaapps.

PS: For some reason, spotify doesn't use the cached credentials. Therefore it always asks for login-data.
