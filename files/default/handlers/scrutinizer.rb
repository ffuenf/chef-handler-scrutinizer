#!/usr/bin/env ruby
# Chef Reporting Handler for Scrutinizer.
#
# Author:: Achim Rosenhagen <a.rosenhagen@ffuenf.de>
# Copyright:: Copyright 2015 Achim Rosenhagen
# License:: Apache License 2.0
#

require 'rubygems'
require 'net/https'
require 'uri'
require 'yaml'
require 'chef/log'
require 'chef/handler'

class Chef
  class Handler
    # Scrutinizer handler to invoke tests on Scrutinizer after successfull Chef run
    class Scrutinizer < Chef::Handler
      VERSION = '1.0.0'

      def initialize(config)
        @api_url = config['api_url']
        @access_token = config['access_token']
        @endpoint_type = get_endpoint_type(config['type'])
        @repository_name = config['repository_name']
        @branch = config['branch']
        @source_reference = config['source_reference'].nil? ? 'HEAD' : config['source_reference']
        @title = config['title']
        @config = create_yml_from_file(config['config'])
        @http = create_http_service(config['api_url'])
      end

      def report
        return if run_status.failed?
        if @access_token.nil?
          Chef::Log.warn('You need an access token to let Chef report successfull runs to Scrutinizer')
          fail ArgumentError, 'Missing Scrutinizer Access Token'
        else
          uri = URI.parse(@api_url + '/repositories/' + @endpoint_type + '/' + @repository_name + '/inspections?access_token=' + @access_token)
          request = Net::HTTP::Post.new(uri.request_uri)
          request.add_field('Content-Type', 'application/json')
          request.body = {
            'branch' => @branch,
            'source_reference' => @source_reference,
            'title' => @title.nil? ? "Chef client run #{run_status_human_readable} on #{run_status.node.name} deployed with #{@source_reference} on #{@repository_name}/#{@branch}" : @title,
            'config' => @config
          }.to_json
          response = @http.request(request)
          Chef::Log.info(response)
          if response.code.to_i < 200 || response.code.to_i >= 300
            fail StandardError, "Report failed with status #{response.code}"
          end
        end
      end

      private

      def create_http_service(url)
        uri = URI(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http
      end

      def create_yml_from_file(file)
        yml_string = YAML.load_file(file)
        yml_string = YAML.dump(yml_string.to_hash)
        yml_string
      end

      def get_endpoint_type(type)
        case type
        when 'github'
          'g'
        when 'bitbucket'
          'b'
        else
          'gp'
        end
      end

      def run_status_human_readable
        run_status.success? ? 'succeeded' : 'failed'
      end
    end
  end
end
