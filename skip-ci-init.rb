#!/usr/bin/env ruby
#-*- encoding : utf-8 -*-
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

open('.git/hooks/prepare-commit-msg', 'a') do |f|
  f.puts %q{
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    if [ "$BRANCH" != "master" ];then
      test "`grep '\[skip ci\]' $1`" != "" || echo "[skip ci]" >> "$1"
    fi
  }.gsub(/^\s+/, '')
end
