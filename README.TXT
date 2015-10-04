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

# At this point i have to say that there is a strange behavior with spotify. If I use "docker run" to start spotify everything is fine. 
# But if I start skype with "docker run", and then another container with spotify using "docker run", spotify always tells me that
# it is already running. That's why my script checks if there is already a container running. If it is so, the script will just execute the
# application inside of this already running container using "docker exec".

Making changes permanent:
-------------------------
The configuration-files for spotify and skype are persistent. It is realized by mounted volumes in $HOME/.spotify and $HOME.Skype. For some reason, spotify doesn't use the cached credentials. Therefore it always asks for login-data.
