#
# Cookbook Name:: pk
# Attributes:: default
#
# Copyright 2012, Jacques Marneweck.
#
# All rights reserved - Do Not Redistribute
#

default['pk'] = {
  'pkgsrc_release' => 'pkgsrc_2012Q1',
  'repos' => {
    'pk' => 'git://github.com/textdrive/pk.git',
    'pkgsrc' => 'git://github.com/joyent/pkgsrc.git'
  }
}
