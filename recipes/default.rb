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

execute "git-pk-add-upstream" do
  command "cd /opt/pk && git add upstream git://github.com/mamash/pk.git"
  action :nothing
end

execute "git-pkgsrc-add-upstream" do
  command "cd /opt/pkgsrc && git add upstream git://github.com/joyent/pkgsrc.git"
  action :nothing
end

execute "git-pkgsrc-joyent-add-upstream" do
  command "cd /opt/pkgsrc/joyent && git add upstream git://github.com/joyent/pkgsrc-joyent.git"
  action :nothing
end

execute "git-pkgsrc-wip-add-upstream" do
  command "cd /opt/pkgsrc/wip && git add upstream git://github.com/joyent/pkgsrc-joyent.git"
  action :nothing
end

execute "git-clone-pkgsrc" do
  command "cd /opt && git clone -b #{node[:pk][:pkgsrc_release]} #{node[:pk][:repos][:pkgsrc]}"
  not_if "test -d /opt/pkgsrc"
  notifies :run, "execute[git-pkgsrc-add-upstream]", :immediately
  notifies :run, "execute[git-pkgsrc-joyent-add-upstream]", :immediately
  notifies :run, "execute[git-pkgsrc-wip-add-upstream]", :immediately
  notifies :run, "execute[git-fix-submodules]", :immediately
  notifies :run, "execute[git-submodule-init]", :immediately
end

execute "git-clone-pk" do
  command "cd /opt && git clone -b #{node[:pk][:pkgsrc_release]} #{node[:pk][:repos][:pk]}"
  not_if "test -d /opt/pk"
  notifies :run, "execute[git-pk-add-upstream]", :immediately
end
