require 'spec_helper'
require_relative '../lib/request_parser'

describe 'RequestParser' do
  describe '#parse' do
    it '#get' do
      request = <<~REQUEST
        GET / HTTP/1.1\r
        Host: localhost:5678\r
        User-Agent: curl/7.88.1\r
        Accept: */*\r
        \r
      REQUEST

      json = RequestParser.new(request).parse

      expect(json).to eq({
                           :"method" => 'GET',
                           :"path" => '/',
                           :"version" => 'HTTP/1.1',
                           :"headers" => { :"host" => 'localhost:5678',
                                           :"user-agent" =>'curl/7.88.1',
                                           :"accept" => '*/*',
                                          },
                          :"params" => nil
                        })
    end

    it '#post' do
      request = <<~REQUEST
        POST /parkings HTTP/1.1\r
        Host: localhost:5678\r
        User-Agent: curl/7.88.1\r
        Accept: */*\r
        Content-Length: 18\r
        Content-Type: application/json\r
        \r
        {\"plate\": aaa-4444}
      REQUEST

      json = RequestParser.new(request).parse

      expect(json).to eq({
                           :"method" => 'POST',
                           :"path" => '/parkings',
                           :"version" => 'HTTP/1.1',
                           :"headers" => { :"host" => 'localhost:5678',
                                           :"user-agent" =>'curl/7.88.1',
                                           :"accept" => '*/*',
                                           :"content-type" => 'application/json',
                                           :"content-length" => '18' },
                          :"params" => {:"plate"=> "aaa-4444"}
                        })
    end

    it '#put' do
      request = <<~REQUEST
        PUT /parkings/aaa-4444 HTTP/1.1\r
        Host: localhost:5678\r
        User-Agent: curl/7.68.0\r
        Accept: */*\r
        Content-type: application/json\r
        Content-Length: 21\r
        \r
      REQUEST

      json = RequestParser.new(request).parse

      expect(json).to eq({
                           :"method" => 'PUT',
                           :"path" => '/parkings',
                           :"version" => 'HTTP/1.1',
                           :"headers" => { :"host" => 'localhost:5678',
                                           :"user-agent" =>'curl/7.68.0',
                                           :"accept" => '*/*',
                                           :"content-type" => 'application/json',
                                           :"content-length" => '21' },
                          :"params" => {:"plate"=> "aaa-4444"}
                        })
    end
  end
end
