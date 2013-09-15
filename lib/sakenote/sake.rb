module Sakenote
  class Sake
    def initialize(name, identify_code: nil, furigana: nil, alphabet: nil, maker: nil)
      @name          = name
      @identify_code = identify_code
      @furigana      = furigana
      @alphabet      = alphabet
      @maker         = maker
    end

    attr_reader :name, :identify_code, :furigana, :alphabet, :maker
  end
end