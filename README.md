# Wikimedia::Commoner

Wikimedia Commons has an api, but sometimes it isn't that helpful. This gem is used by OpenPlaques.org to handle all the wrangling to get hold of image links and appropriate copyright holder details so that an image can be legally displayed on a web page.

With thanks to Ross Cooperman for the inspiration with his 2013 commoner gem. I did try a pull request.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wikimedia-commoner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wikimedia-commoner

## Usage

require 'commoner'

wikimedia = Commoner.details("File:"+wikimedia_filename)
wikimedia[:categories]
wikimedia[:url]
wikimedia[:page_url]
wikimedia[:description]
wikimedia[:author]
wikimedia[:author_url]
wikimedia[:licence]
wikimedia[:licence_url])

Commoner.search 'term'

Commoner.images 'term'

Commoner.categorised_images 'category'

## Contributing

1. Fork it ( https://github.com/[my-github-username]/wikimedia-commoner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
