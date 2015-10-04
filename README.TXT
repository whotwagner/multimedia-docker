This project contains a dockerfile for building a multimedia-image. This images is
based on ubuntu trusty and has google-chrome, skype, firefox and spotify pre-installed.
You could use this docker-image to keep your system clean from closed-source software by
seperating it using a container. Of course it is possible to run all those applications at once


Requirements:
-------------

- pulseaudio running on the host
- X11 running on the host




Building the image:
--------------------

./run_mm.sh build

Using the image:
------------------
# run spotify
./run_mm.sh spotify

# run google-chrome
./run_mm.sh google-chrome

# run skype
./run_mm.sh skype 

# run a shell
./run_mm.sh bash

# run firefox
./run_mm.sh firefox

# At this point i have to say that there is a strange behavior with spotify. 
# If I am going to use "docker run" to start spotify everything is fine. 
# But if I'll start skype with "docker run", and then another container with spotify 
# using "docker run", spotify always tells me that it is already running. 
# I solved that problem by checking if a container is already running 
# If it, the script will just execute the application inside of this 
# already running container using "docker exec".

Making changes permanent:
-------------------------
The configuration-files for spotify and skype are persistent. It is realized by mounted volumes in $HOME/.mymultimediaapps.
I manually added all the volumes in run_mm.sh, so it is easy to remove one if you don't want to cache the configuration 
of one specific app. 

PS: For some reason, spotify doesn't use the cached credentials. Therefore it always asks for login-data.
