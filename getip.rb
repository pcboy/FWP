#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-
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

require 'json'
require 'awesome_print'

project_name_re = Regexp.new(ARGV.shift)
selected_env = ARGV.shift || 'staging'

envs = JSON.parse(%x{aws elasticbeanstalk describe-environments})

active_envs = envs["Environments"].map do |env|
  if env["Health"] == "Green" && project_name_re =~ env["ApplicationName"].downcase && env["EnvironmentName"].include?(selected_env)
    env["EnvironmentName"]
  end
end.compact

instances = JSON.parse(%x{aws ec2 describe-instances})
instances = instances['Reservations'].flat_map{|x| x['Instances']}

target_instances = active_envs.map do |active|
	instance = instances.find{|x| x['Tags'].any?{|y| active == y['Value'] }}
	{instance: active, ip: instance['PrivateIpAddress']}
end
puts target_instances.map{|x| x[:ip]}.join("\n")
