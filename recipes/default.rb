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

execute "git-fix-submodules" do
  command "cd /opt/pkgsrc && gsed -i'' -e '/mamash/s/mamash/joyent/g' .gitmodules"
  action :nothing
end

execute "git-submodule-init" do
  command "cd /opt/pkgsrc && git submodule init && git submodule update"
  action :nothing
end

execute "git-clone-pkgsrc" do
  command "cd /opt && git clone -b #{node[:pk][:pkgsrc_release]} #{node[:pk][:repos][:pkgsrc]}"
  not_if "test -d /opt/pkgsrc"
  notifies :run, "execute[git-fix-submodules]", :immediately
  notifies :run, "execute[git-submodule-init]", :immediately
end

execute "git-clone-pk" do
  command "cd /opt && git clone -b #{node[:pk][:pkgsrc_release]} #{node[:pk][:repos][:pk]}"
  not_if "test -d /opt/pk"
end
