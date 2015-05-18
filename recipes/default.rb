#
# Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)
# Cookbook Name:: chef-handler-scrutinizer
# Recipe:: scrutinizer
#
# Copyright 2015, Achim Rosenhagen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_directory node['chef_handler']['handler_path'] do
  source 'handlers'
  action :nothing
end.run_action(:create)

chef_handler 'Chef::Handler::Scrutinizer' do
  source "#{node['chef_handler']['handler_path']}/scrutinizer.rb"
  arguments [
    node['scrutinizer']['chef-handler']
  ]
  supports 'report' => true
  action :nothing
end.run_action(:enable)
