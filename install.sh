#!/bin/bash
#
# Debian based OS system upgrade service
#
# Should work on any Debian based OS
#
#  Based on my tutorial video
# Found at https://odysee.com/@RTP channel
# Main Blog: https://buymeacoffee.com/politictech/posts
#

echo "Installing Automatic Upgrade Service..."
sleep .5
echo ''

# Satisfy requirements first
read -p "Are you ready to install? (y/n) " prompt
echo ''
if [[ $prompt == "yes" || $prompt == "Y" || $prompt == "Yes" || $prompt == "YES" || $prompt == "y" ]]
then
	echo "Ok."
else
	echo "Cannot continue."
	exit 1
fi

echo ''
sleep .5
echo ''
read -p "Do you have systemd? (required) (y/n) " sysdques
echo ''

if [[ $sysdques == "yes" || $sysdques == "Y" || $sysdques == "Yes" || $sysdques == "YES" || $sysdques == "y" ]]
then
	echo "Ok. Putting everything where it needs to be..."
	cp deb-upgrade /usr/sbin/deb-upgrade
	cp upgrade.service /etc/systemd/system/upgrade.service
	echo ' '
	sleep .5
	echo "Making deb-upgrade executable..."
	chmod +x /usr/sbin/deb-upgrade
	echo ' '
	sleep .5
	echo "Now updating Systemd Services..."
	echo ''
	sleep .5
	echo ' '
	systemctl daemon-reload
	systemctl enable upgrade
	echo "Starting Upgrade Service (for boot)"
	echo ' '
	systemctl start upgrade
	echo "Finished."
	sleep .5
	echo ' '
	echo "Now checking status..."
	echo ' '
	sleep .5
	systemctl status upgrade
	sleep .5
	echo ' '
	echo "Hopefully everything looks good!"
	echo ' '
	sleep .5
	echo "Exiting."
	exit 0
else
	exit 1
fi
