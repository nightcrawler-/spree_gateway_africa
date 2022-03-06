# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'
require 'base64'

module Paygo
  class MtnCollectionService
    attr_reader :username, :password, :service_id, :client_id, :body

    # TODO: : Configurable on Spree admin - unless is fixed?
    def endpoint
      'https://dss-gw-loadbal-uat01.digitalpaygo.com:9906/ServiceLayer/request/postRequest'
    end

    def initialize(username, password, service_id, client_id, body)
      @username = username
      @password = password
      @client_id = client_id
      @service_id = service_id

      @body = body
    end

    def call
      payload = @body.merge!({ username: @username,
                               password: @password,
                               clientid: @client_id,
                               serviceid: @service_id })

      puts "PayGo MTN Collection Payload: #{payload}"

      post_data(payload)
    end

    private

    def post_data(payload)
      url = URI(endpoint)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request['Content-Type'] = 'application/json'
      request.body = payload.to_json

      puts "Payload: #{payload.to_json}"
      response = https.request(request)
      puts "Completed sending Online Payment Request\ncode: #{response.code}\nbody: #{response.body}"

      OpenStruct.new({ success?: response.code.eql?('200'), payload: JSON.parse(response.body) })
    end
  end
end
