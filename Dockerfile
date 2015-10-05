# This Dockerfile was tested with ubuntu trusty
# Debian jessie works too, but you have to uncomment the right lines
# and comment the UBUNTU-lines below
FROM ubuntu

MAINTAINER hoti

ENV DEBIAN_FRONTEND noninteractive


RUN useradd -m -U pt
RUN echo "pt:BestUser4Ever" | chpasswd

# Install wget and pulseaudio(mplayer is nice too)
RUN apt-get update && apt-get install -y mplayer pulseaudio wget openssh-server

# Pepper-Flash-Stuff
RUN echo deb http://archive.ubuntu.com/ubuntu/ trusty multiverse | tee /etc/apt/source.list
RUN echo deb http://archive.ubuntu.com/ubuntu/ trusty-updates multiverse | tee /etc/apt/source.list

# Chrome-Stuff
RUN wget  -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN echo deb http://dl.google.com/linux/chrome/deb/ stable main | tee  /etc/apt/sources.list.d/google-chrome.list


# Spotify-Stuff
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
RUN echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

# Skype-Stuff
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y libc6:i386 libqt4-dbus:i386 libqt4-network:i386 libqt4-xml:i386 libqtcore4:i386 libqtgui4:i386 libqtwebkit4:i386 libstdc++6:i386 libx11-6:i386 libxext6:i386 libxss1:i386 libxv1:i386 libssl1.0.0:i386 libpulse0:i386 libasound2-plugins:i386

# Install Skype
RUN wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb && dpkg -i skype-install.deb

# Install Spotify
RUN apt-get install -y libpangoxft-1.0-0 spotify-client

# UNCOMMENT THIS FOR A DEBIAN-BASE-IMAGE: We need libgcrypt11 from wheezy
#RUN wget -O http://ftp.at.debian.org/debian/pool/main/libg/libgcrypt11/libgcrypt11_1.5.0-5+deb7u3_amd64.deb && dpkg -i libgcrypt11_1.5.0-5+deb7u3_amd64.deb
#RUN apt-get install -y iceweasel

# UNCOMMENT THIS FOR A UBUNTU-BASE-IMAGE:
RUN apt-get install -y libgcrypt11 firefox

# Install Chrome
RUN apt-get install -y google-chrome-stable

# Install Pepperflash
RUN apt-get install -y pepperflashplugin-nonfree
RUN update-pepperflashplugin-nonfree --install

USER pt

WORKDIR /home/pt

