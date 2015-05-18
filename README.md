chef-handler-scrutinizer
========================
[![GitHub tag](http://img.shields.io/github/tag/ffuenf/chef-handler-scrutinizer.svg)][tag]
[![Build Status](http://img.shields.io/travis/ffuenf/chef-handler-scrutinizer.svg)][travis]
[![Gittip](http://img.shields.io/gittip/arosenhagen.svg)][gittip]

[tag]: https://github.com/ffuenf/chef-handler-scrutinizer/tags
[travis]: https://travis-ci.org/ffuenf/chef-handler-scrutinizer
[gittip]: https://www.gittip.com/arosenhagen

chef-handler-scrutinizer installs/configures a chef_handler which triggers a inspection on [scrutinizer-ci](https://scrutinizer-ci.com) on successful Chef run.

Attributes
----------

`node[chef_handler]["handler_path"]` - location to drop off handlers directory, default is `/var/chef/handlers`.

`node['scrutinizer']['chef-handler']['api_url']` - Scrutinizer API Endpoint, default is `https://scrutinizer-ci.com/api`.
`node['scrutinizer']['chef-handler']['access_token']` - Scrutinizer Access Token, required, default is `nil`.
`node['scrutinizer']['chef-handler']['type']` - Repository type, g = github / b = bitbucket / nil = git, default is `nil`.
`node['scrutinizer']['chef-handler']['repository_name']` - Repository name, default is `nil`.
`node['scrutinizer']['chef-handler']['branch']` - Repository branch, default is `master`.
`node['scrutinizer']['chef-handler']['source_reference']` - Git reference, default is `HEAD`.
`node['scrutinizer']['chef-handler']['title']` - Title to report on Scrutinizer, default is `Chef client run succeeded on X deployed with X on X/X`.
`node['scrutinizer']['chef-handler']['config']` - Path to custom Scrutinizer YML config, default is `#{node['chef_handler']['handler_path']}/scrutinizer.yml`.

Usage
-----

Put the recipe `chef_handler` and `chef-handler-scrutinizer` at the start of the node's run list to make sure that custom handlers are dropped off early on in the Chef run and available for later recipes.

Requirements
------------

* Ruby >= 1.9

Dependencies
------------

This cookbook depends on the following community cookbooks.

* chef_handler

Platform
--------

The following platforms are supported and tested:

* Debian 7.x

Development
-----------
1. Fork the repository from GitHub.
2. Clone your fork to your local machine:

        $ git clone git@github.com:USER/chef-handler-scrutinizer.git

3. Create a git branch

        $ git checkout -b my_bug_fix

4. **Write tests**
5. Make your changes/patches/fixes, committing appropriately
6. Run the tests: `foodcritic`, `rubocop`, `kitchen test`
7. Push your changes to GitHub
8. Open a Pull Request

Testing
-------

chef-handler-scrutinizer is on [Travis CI](http://travis-ci.org/ffuenf/chef-handler-scrutinizer) which tests against multiple Chef and Ruby versions.

The following Rake tasks are provided for automated testing of the cookbook:

* `rake rubocop` - Run [RuboCop] style and lint checks
* `rake foodcritic` - Run [Foodcritic] lint checks
* `rake integration` - Run [Test Kitchen] integration tests (provisions a
  Vagrant VM using this cookbook and then tests the infrastructure with
  [Serverspec])
* `rake test` - Run all tests

License and Authors
-------------------

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
