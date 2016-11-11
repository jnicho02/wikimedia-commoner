# Wikimedia::Commoner

The Wikimedia Commons api does not provide everything that you need to display their images, e.g. the name of the copyright holder and the licence details. This gem scrapes the html to add to the api. It is not foolproof, but will work for most of the images.

This gem is used by OpenPlaques.org to get hold of image links and appropriate copyright holder details so that an image can be legally displayed on a web page.

The idea is that users can copy and paste any Wikimedia filename to your system and you can get the details. It looks for anything with 'File:' in the url, so can cope with different formats coming from preview urls, etc.:
* https://commons.wikimedia.org/wiki/File:Ciconia_ciconia_-_01.jpg
* https://commons.wikimedia.org/wiki/Main_Page#/media/File:Ciconia_ciconia_-_01.jpg
* File:Ciconia_ciconia_-_01.jpg
* https://commons.wikimedia.org/wiki/File:Plaque_in_Fortune_Street.jpg#.7B.7Bint:filedesc.7D.7D

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
```
require 'wikimedia/commoner'
wikimedia = Wikimedia::Commoner.details("File:Ciconia_ciconia_-_01.jpg")
wikimedia[:categories]
wikimedia[:url]
wikimedia[:page_url]
wikimedia[:description]
wikimedia[:author]
wikimedia[:author_url]
wikimedia[:licence]
wikimedia[:licence_url]
wikimedia[:longitude]
wikimedia[:latitude]
wikimedia[:openplaques_id]

Wikimedia::Commoner.search 'badger'

Wikimedia::Commoner.images 'badger'

Wikimedia::Commoner.categorised_images 'Category:Badger Bus'
```

You can try it with

    $ rake console
    > wikimedia = Wikimedia::Commoner.details("https://commons.wikimedia.org/wiki/File:Chongqing_Art_Museum.jpg")

## Contributing

1. Fork it ( https://github.com/jnicho02/wikimedia-commoner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Write some rspec (`rspec`). I won't accept anything without a test to demo it.
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

Credit to Ross Cooperman for his 2013 commoner gem. I did try a pull request.
