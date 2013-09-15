require 'faraday'
require 'faraday_middleware'

require 'sakenote/error'
require 'sakenote/error/configuration_error'
require 'sakenote/search_result'
require 'sakenote/sake'
require 'sakenote/maker'

module Sakenote
  class Client
    def initialize(token)
      if token.is_a?(String) && token.strip.length > 0
        @token = token
        @conn  = connection
      else
        raise Sakenote::Error::ConfigurationError
      end
    end

    # https://www.sakenote.com/api/v1/sakes
    def sakes(prefecture_code: nil, sake_name: nil, maker_name: nil, page: 1)
      options = {
        token:           @token,
        prefecture_code: prefecture_code,
        sake_name:       sake_name,
        maker_name:      maker_name,
        page:            page
      }.select{ |k, v| !v.nil? }

      response = @conn.get '/api/v1/sakes', options

      num_pages = response.body['num_pages'].to_i
      list      = response.body['sakes'].map { |s|
        Sake.new(s['sake_name'],
          identify_code: s['sake_identify_code'],
          furigana:      s['sake_furigana'],
          alphabet:      s['sake_alphabet'],
          maker:         Maker.new(s['maker_name'],
            postcode: s['maker_postcode'],
            address:  s['maker_address'],
            url:      s['maker_url']
          )
        )
      }

      SearchResult.new(list, num_pages)
    end

    # https://www.sakenote.com/api/v1/makers
    def makers(prefecture_code: nil, maker_name: nil, page: 1)
      options = {
        token:           @token,
        prefecture_code: prefecture_code,
        maker_name:      maker_name,
        page:            page
      }.select{ |k, v| !v.nil? }

      response = @conn.get '/api/v1/makers', options

      num_pages = response.body['num_pages'].to_i
      list      = response.body['makers'].map { |s|
        Maker.new(s['maker_name'],
          postcode: s['maker_postcode'],
          address:  s['maker_address'],
          url:      s['maker_url']
        )
      }

      SearchResult.new(list, num_pages)
    end

    def connection
      faraday = Faraday.new 'https://www.sakenote.com' do |conn|
        conn.request  :json
        conn.response :json, :content_type => /\bjson$/
        conn.adapter  Faraday.default_adapter
      end

      faraday.headers[:user_agent] = "Sakenote/#{Sakenote::VERSION} (sakenote-rubygems/#{Sakenote::VERSION})"
      faraday
    end
  end
end