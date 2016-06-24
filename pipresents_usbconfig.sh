#!/bin/sh
# This script is designed to install pipresents and make it run a live slideshow
#   automatically on a fresh install of Raspbian Jessie.
# Developed by Alex Riviere at the Infinite Energy Center in Duluth, GA to
#   quickly flash new pis to be a easy signage device.

# first update apt.
echo "apt-get update..."
sudo apt-get -q update

# Next, Install usbmount so that pipresents can always find it in /media/usb0
echo "install usbmount..."
sudo apt-get -qy install usbmount

# Install all the dependancies for pipresents
echo "install python-imaging..."
sudo apt-get -qy install python-imaging
echo "install python-imaging-tk..."
sudo apt-get -qy install python-imaging-tk
echo "install unclutter..."
sudo apt-get -qy install unclutter
echo "install mplayer..."
sudo apt-get -qy install mplayer
echo "install uzbl..."
sudo apt-get -qy install uzbl

# And install the pip dependancies
echo "install pexpect."
sudo pip -q install pexpect

# and for good measure, make sure git is installed
echo "install git..."
sudo apt-get -qy install git

# Actually go get pipresents and put it in /home/pi/pipresents
echo "Download pipresents..."
git clone https://github.com/KenT2/pipresents-gapless.git /home/pi/pipresents

# copy our liveshow profile over to the correct place
echo "Make dir pp_home/pp_profiles/..."
mkdir /home/pi/pp_home
mkdir /home/pi/pp_home/pp_profiles
echo "Copy pipresents_usbconfig to pp_profiles..."
cp -r pipresents_usbconfig /home/pi/pp_home/pp_profiles/pipresents_usbconfig

# change our autostart file
echo "Backup autostart to autostart.old..."
mv /home/pi/.config/lxsession/LXDE-pi/autostart /home/pi/.config/lxsession/LXDE-pi/autostart.old
echo "Make new autostart..."
cat <<EOF > /home/pi/.config/lxsession/LXDE-pi/autostart
@xset s noblank
@xset s off
@xset -dpms
/usr/bin/python /home/pi/pipresents/pipresents.py -f -o /home/pi -p pipresents_usbconfig
EOF

echo "Everything should work now. Enjoy!"
