module Sakenote
  class SearchResult
    def initialize(list, num_pages)
      @list      = list
      @num_pages = num_pages
    end

    attr_reader :list, :num_pages
  end
end