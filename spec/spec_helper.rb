require 'wikimedia/commoner'
require 'webmock'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
  config.allow_http_connections_when_no_cassette = true
end
