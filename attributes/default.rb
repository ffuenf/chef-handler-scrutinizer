#
# Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)
# Cookbook Name:: chef-handler-scrutinizer
# Attribute:: default
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

default['scrutinizer']['chef-handler']['api_url'] = 'https://scrutinizer-ci.com/api'
default['scrutinizer']['chef-handler']['access_token'] = nil # required!
default['scrutinizer']['chef-handler']['type'] = nil # g = github / b = bitbucket
default['scrutinizer']['chef-handler']['repository_name'] = nil
default['scrutinizer']['chef-handler']['branch'] = 'master'
default['scrutinizer']['chef-handler']['source_reference'] = 'HEAD'
default['scrutinizer']['chef-handler']['title'] = nil
default['scrutinizer']['chef-handler']['config'] = "#{node['chef_handler']['handler_path']}/scrutinizer.yml"
