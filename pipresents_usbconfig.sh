#!/bin/sh
# This script is designed to install pipresents and make it run a live slideshow
#   automatically on a fresh install of Raspbian Jessie.
# Developed by Alex Riviere at the Infinite Energy Center in Duluth, GA to
#   quickly flash new pis to be a easy signage device.

# first update apt.
sudo apt-get update

# Next, Install usbmount so that pipresents can always find it in /media/usb0
sudo apt-get install usbmount

# Install all the dependancies for pipresents
sudo apt-get install python-imaging
sudo apt-get install python-imaging-tk
sudo apt-get install unclutter
sudo apt-get install mplayer
sudo apt-get install uzbl

# And install the pip dependancies
sudo pip install pexpect

# and for good measure, make sure git is installed
sudo apt-get install git

# Actually go get pipresents and put it in /home/pi/pipresents
git clone https://github.com/KenT2/pipresents-gapless.git /home/pi/pipresents

# copy our liveshow profile over to the correct place
cp pipresents_usbconfig /home/pi/pp_home/pp_profiles/pipresents_usbconfig

# change our autostart file
mv /home/pi/.config/lxsession/LXDE-pi/autostart /home/pi/config/lxsession/LXDE-pi/autostart.old
cat <<EOF > /home/pi/.config/lxsession/LXDE-pi/autostart
@xset s noblank
@xset s off
@xset -dpms
/usr/bin/python /home/pi/pipresents/pipresents.py -f -o /home/pi -p pipresents_usbconfig
EOF
