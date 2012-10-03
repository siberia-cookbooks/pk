#
# Cookbook Name:: pk
# Recipe:: default
#
# Copyright 2012, Jacques Marnweck
#
# All rights reserved - Do Not Redistribute
#

%w{
  bmake
  digest
  pax
  tnftp
  gcc47
  scmgit-base
}.each do |p|
  package "#{p}" do
    action :install
  end
end

execute "git-submodule-init" do
  command "cd /opt/pkgsrc && git submodule init && git submodule update"
  action :nothing
  subscribes :run, "git[/opt/pkgsrc]", :immediately
end

execute "git-pk-remote-add-upstream" do
  command "cd /opt/pk && git remote add upstream git://github.com/mamash/pk.git"
  not_if {node[:pk][:repos][:pk] == "git://github.com/mamash/pk.git"}
  action :nothing
  subscribes :run, "git[/opt/pk]", :immediately
end

execute "git-pkgsrc-remote-add-upstream" do
  command "cd /opt/pkgsrc && git remote add upstream git://github.com/joyent/pkgsrc.git"
  not_if {node[:pk][:repos][:pkgsrc] == "git://github.com/joyent/pkgsrc.git"}
  action :nothing
  subscribes :run, "git[/opt/pkgsrc]", :immediately
end

execute "git-pkgsrc-joyent-remote-add-upstream" do
  command "cd /opt/pkgsrc/joyent && git remote add upstream git://github.com/joyent/pkgsrc-joyent.git"
  not_if {node[:pk][:repos][:pkgsrc] == "git://github.com/joyent/pkgsrc.git"}
  subscribes :run, "git[/opt/pkgsrc]", :immediately
  action :nothing
end

execute "git-pkgsrc-wip-remote-add-upstream" do
  command "cd /opt/pkgsrc/wip && git remote add upstream git://github.com/joyent/pkgsrc-joyent.git"
  not_if {node[:pk][:repos][:pkgsrc] == "git://github.com/joyent/pkgsrc.git"}
  subscribes :run, "git[/opt/pkgsrc]", :immediately
  action :nothing
end

git "/opt/pkgsrc" do
  repository "#{node[:pk][:repos][:pkgsrc]}"
  reference "#{node[:pk][:pkgsrc_release]}"
  user "root"
  group "root"
  action :checkout
  not_if "test -d /opt/pkgsrc"
end

git "/opt/pk" do
  repository "#{node[:pk][:repos][:pk]}"
  if node[:pk][:pkgsrc_release] == "pkgsrc_2012Q2"
    reference "master"
  else
    reference "#{node[:pk][:pkgsrc_release]}"
  end
  user "root"
  group "root"
  action :checkout
  not_if "test -d /opt/pk"
end

cookbook_file "/opt/pk/bin/generate-pkg_summary" do
  source "generate-pkg_summary"
  owner "root"
  group "wheel"
  mode "0600"
end

cookbook_file "/root/.pkrc" do
  source ".pkrc"
  owner "root"
  group "root"
  mode "0600"
end
