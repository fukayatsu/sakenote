# Sakenote
Sakenote API client

- [日本酒アプリSakenote](http://sakenote.com/)

## Installation

Add this line to your application's Gemfile:

    gem 'sakenote'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sakenote

## Usage

- [get access token](https://www.sakenote.com/access_tokens)
- [Sakenote API v1 docs](http://docs.sakenote.apiary.io/)

```ruby
require 'sakenote'

# initialize client
client = Sakenote::Client.new('YOUR SAKENOTE TOKEN')

# search Sake
#   options:
#     prefecture_code: 都道府県コード(integer)
#     sake_name:       銘柄の名前(string)
#     maker_name:      酒造の名前(string)
#     page:            取得するページ番号(integer)
search_result = client.sakes(sake_name: '雪の茅舎')
puts search_result.num_pages #=> 1

sake = search_result.list.first
puts sake.identify_code #=> 'P002384'
puts sake.name          #=> '雪の茅舎'
puts sake.furigana      #=> 'ゆきのぼうしゃ'
puts sake.alphabet      #=> 'yukinobousha'

maker = sake.maker
puts maker.name      #=> '齋彌酒造店'
puts maker.postcode  #=> '036-8366'
puts maker.address   #=> '秋田県由利本荘市石脇字石脇53'
puts maker.url       #=> 'http://www.yukinobousha.jp/'

# search Maker
#   options:
#     prefecture_code: 都道府県コード(integer)
#     maker_name:      酒造の名前(string)
#     page:            取得するページ番号(integer)
search_result = client.makers(prefecture_code: 05) # 05: Akita (ISO 3166-2:JP)
puts search_result.num_pages #=> 1

maker = search_result.list[1]
puts maker.name      #=> '阿桜酒造'
puts maker.postcode  #=> '013-0041'
puts maker.address   #=> '秋田県横手市大沢字西野67-2'
puts maker.url       #=> 'http://www.azakura.co.jp/'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
