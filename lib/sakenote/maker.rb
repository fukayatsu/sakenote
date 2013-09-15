module Sakenote
  class Maker
    def initialize(name, postcode: nil, address: nil, url: nil)
      @name     = name
      @postcode = postcode
      @address  = address
      @url      = url
    end

    attr_reader :name, :postcode, :address, :url
  end
end