#!/usr/bin/env bash
#
#          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                  Version 2, December 2004
#
#  Copyright (C) 2004 Sam Hocevar
#  14 rue de Plaisance, 75014 Paris, France
#  Everyone is permitted to copy and distribute verbatim or modified
#  copies of this license document, and changing it is allowed as long
#  as the name is changed.
#  DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#
#
#  David Hagege <david.hagege@gmail.com>
#
#set -euo pipefail
IFS=$'\n'

adb root
sleep 2

PACKAGES=`adb shell pm list packages -f -3 | grep -v system`
mkdir -f {data,app}
rm -rf data/*
rm -rf app/*
for i in $PACKAGES;do
  PKG=`echo $i | ruby -e 'puts /package:\/data\/app\/(.*)\/base.apk=/.match(STDIN.read).captures'`
  echo $PKG
  PKG_DATA=`echo $PKG | ruby -e 'puts /(.*)-\d/.match(STDIN.read).captures'`
  adb pull -a /data/app/$PKG app/$PKG
  adb pull -a /data/data/$PKG_DATA data/$PKG_DATA
done
