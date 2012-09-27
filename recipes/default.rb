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
end

execute "git-pk-remote-add-upstream" do
  command "cd /opt/pk && git remote add upstream git://github.com/mamash/pk.git"
  not_if {node[:pk][:repos][:pk] == "git://github.com/mamash/pk.git"}
  action :nothing
end

execute "git-pkgsrc-remote-add-upstream" do
  command "cd /opt/pkgsrc && git remote add upstream git://github.com/joyent/pkgsrc.git"
  not_if {node[:pk][:repos][:pkgsrc] == "git://github.com/joyent/pkgsrc.git"}
  action :nothing
end

execute "git-pkgsrc-joyent-remote-add-upstream" do
  command "cd /opt/pkgsrc/joyent && git remote add upstream git://github.com/joyent/pkgsrc-joyent.git"
  not_if {node[:pk][:repos][:pkgsrc] == "git://github.com/joyent/pkgsrc.git"}
  action :nothing
end

execute "git-pkgsrc-wip-remote-add-upstream" do
  command "cd /opt/pkgsrc/wip && git remote add upstream git://github.com/joyent/pkgsrc-joyent.git"
  not_if {node[:pk][:repos][:pkgsrc] == "git://github.com/joyent/pkgsrc.git"}
  action :nothing
end

execute "git-clone-pkgsrc" do
  command "cd /opt && git clone -b #{node[:pk][:pkgsrc_release]} #{node[:pk][:repos][:pkgsrc]}"
  not_if "test -d /opt/pkgsrc"
  notifies :run, "execute[git-submodule-init]", :immediately
  notifies :run, "execute[git-pkgsrc-remote-add-upstream]", :immediately
  notifies :run, "execute[git-pkgsrc-joyent-remote-add-upstream]", :immediately
  notifies :run, "execute[git-pkgsrc-wip-remote-add-upstream]", :immediately
end

execute "git-clone-pk" do
  if node[:pk][:pkgsrc_release] == "pkgsrc_2012Q2"
    pk_branch="master"
  else
    pk_branch=node[:pk][:pkgsrc_release]
  end

  command "cd /opt && git clone -b #{pk_branch} #{node[:pk][:repos][:pk]}"
  not_if "test -d /opt/pk"
  notifies :run, "execute[git-pk-remote-add-upstream]", :immediately
end
