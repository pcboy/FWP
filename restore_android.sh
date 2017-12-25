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
for i in `find app -name '*.apk'`;do
  echo $i
  adb install -r $i
done
for i in `ls -1d data/*`;do
 adb push $i/. /data/$i/
done

cat <<EOF > fix_perms.sh
  su
  IFS=$'\n'; for i in \`ls -d /data/user/0/*/\`; do GROUP=\`stat \$i -c %G\`; chown -R \${GROUP}:\${GROUP} \$i; done
EOF
adb shell < fix_perms.sh

