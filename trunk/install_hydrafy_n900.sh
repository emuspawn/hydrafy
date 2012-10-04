#!/bin/bash
tgt_loc=/home/user/MyDocs/pwnphone
tgt_full=$tgt_loc/hydra
if [[ -d $tgt_loc ]];then
        x=1
else
        tgt_loc=/home/user
        tgt_full=$tgt_loc/hydra
fi

if [[ -d $tgt_full ]];then
	rm -rf $tgt_full > /dev/null 2>&1
fi

tar xzf hydrafy-n900.tar.gz
cd hydrafy-n900
mv hydrafy.sh /usr/bin ## Instructions on how to launch hydrafy via the desktop
chmod 755 /usr/bin/hydrafy.sh
mv hydrafy.desktop /usr/share/applications/hildon ## HydraFy GUI Desktop Launcher Thingie..
mv hydrafy_icon.png /opt/usr/share/pixmaps ## Icon
cd ..
rm -rf hydrafy-n900*
rm -rf install_hydrafy_n900.sh
mv hydrafy.sh hydrafy_launch.sh
cd ..
cp -r hydrafy $tgt_loc
rm -rf hydrafy > /dev/null 2>&1
echo -e "\033[1;33m\nHydraFy Successfully Installed, Please Exit This Shell"
read
reset
