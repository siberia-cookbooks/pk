#
# Cookbook Name:: pk
# Recipe:: default
#
# Copyright 2012-2013, Jacques Marnweck
#
# Copyright (c) 2012-2013 Jacques Marneweck. All rights reserved.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

%w{
  bmake
  digest
  pax
  tnftp
  gcc47
  scmgit-base
}.each do |p|
  package p do
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
  not_if {node['pk']['repos']['pk'] == "git://github.com/mamash/pk.git"}
  action :nothing
  subscribes :run, "git[/opt/pk]", :immediately
end

execute "git-pkgsrc-remote-add-upstream" do
  command "cd /opt/pkgsrc && git remote add upstream git://github.com/joyent/pkgsrc.git"
  not_if {node['pk']['repos']['pkgsrc'] == "git://github.com/joyent/pkgsrc.git"}
  action :nothing
  subscribes :run, "git[/opt/pkgsrc]", :immediately
end

execute "git-pkgsrc-joyent-remote-add-upstream" do
  command "cd /opt/pkgsrc/joyent && git remote add upstream git://github.com/joyent/pkgsrc-joyent.git"
  not_if {node['pk']['repos']['pkgsrc'] == "git://github.com/joyent/pkgsrc.git"}
  subscribes :run, "git[/opt/pkgsrc]", :immediately
  action :nothing
end

execute "git-pkgsrc-wip-remote-add-upstream" do
  command "cd /opt/pkgsrc/wip && git remote add upstream git://github.com/joyent/pkgsrc-joyent.git"
  not_if {node['pk']['repos']['pkgsrc'] == "git://github.com/joyent/pkgsrc.git"}
  subscribes :run, "git[/opt/pkgsrc]", :immediately
  action :nothing
end

git "/opt/pkgsrc" do
  repository node['pk']['repos']['pkgsrc']
  reference node['pk']['pkgsrc_release']
  user "root"
  group "root"
  action :checkout
  not_if "test -d /opt/pkgsrc"
end

git "/opt/pk" do
  repository node['pk']['repos']['pk']
  release = node['pk']['pkgsrc_release'].gsub(/joyent\/release\//, '')
  if release == "2012Q2"
    reference "master"
  else
    reference "pkgsrc_#{release}"
  end
  user "root"
  group "root"
  action :checkout
  not_if "test -d /opt/pk"
end

cookbook_file "/opt/pk/bin/generate-pkg_summary" do
  source "generate-pkg_summary"
  owner "root"
  group "root"
  mode "0600"
end

cookbook_file "/root/.pkrc" do
  source ".pkrc"
  owner "root"
  group "root"
  mode "0600"
end
