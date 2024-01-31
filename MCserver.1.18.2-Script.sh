#!/bin/bash

#Noah0302

# Test to see if user is running with root privileges.
if [[ "${UID}" -ne 0 ]]
then
 echo 'Must execute with sudo or root' >&2
 exit 1
fi




#MC Server Debian Installation

apt update -y

apt upgrade -y

apt install wget -y

apt install screen -y




#Java Installieren
wget https://download.java.net/java/GA/jdk17.0.1/2a2082e5a09d4267845be086888add4f/12/GPL/openjdk-17.0.1_linux-x64_bin.tar.gz

tar xvf openjdk-17.0.1_linux-x64_bin.tar.gz

mv jdk-17*/ /opt/jdk17

tee /etc/profile.d/jdk.sh <<EOF
export JAVA_HOME=/opt/jdk17
export PATH=\$PATH:\$JAVA_HOME/bin
EOF

source /etc/profile.d/jdk.sh

java -version

rm openjdk*.gz 





#Minecraft Server Download & Verzeichnis erstellen
mkdir Minecraft

cd Minecraft

wget https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar




#Skript erstellen & Rechte vergeben 6 ausführen
touch start.sh

echo "java -Xms1024M -Xmx2560M -jar server.jar nogui" > start.sh

chmod +x start.sh

./start.sh




#Eula akzeptieren
echo "eula=true" > eula.txt




#Starten
screen ./start.sh