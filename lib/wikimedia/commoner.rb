require 'wikimedia/commoner/version'
require 'httparty'
require 'sanitize'

module Wikimedia
  class Commoner
    def self.search(query)
      new.search(query)
    end

    def self.images(term)
      new.images(term)
    end

    def self.categorised_images(term)
      new.categorised_images(term)
    end

    def self.details(title)
      title = URI.unescape title
      new.details(title)
    end

    def initialize(base_uri = nil)
      @uri = (base_uri) ? base_uri : default_uri
    end

    def search(query)
      json_get(search_uri(query))[1]
    end

    def images(term)
      # get a list of titles for the given term
      response = json_get(query_uri(term))
      images   = response['query']['pages'].map { |page_id, page| page['images'] }
      if images!=[nil]
        titles   = images.flatten.map { |image| image['title'] }
        titles.map do |title|
          details(title)
        end
      end
    end

    def categorised_images(category)
      # get a list of titles for the given term
      response = json_get(category_uri(category))
      images = response['query']['categorymembers']
      if images!=[nil]
        titles = images.flatten.map { |image| image['title'] }
        titles.map do |title|
          if title.start_with?('Category:')
            categorised_images(title)
          else
            details(title)
          end
        end
      end
    end

    def details(title)
      m = /(File:[^#?]*)/.match(title)
      return nil unless m
      title = m[0]
      response = json_get(info_uri(title))
      return {} unless response
      pages = response['query']['pages'].map { |page_id, page| page }
      return { description: 'missing' } if pages.first['missing']!=nil
      categories = pages.first['categories'].map { |category| category['title'] }.flatten
      categories = categories.map { |category| category.gsub(/^Category:/, '') }
      descriptionurl = pages.first['imageinfo'].first['descriptionurl']
      licence = pages.first['imageinfo'].first['extmetadata']['LicenseShortName']['value']
      licence_url = pages.first['imageinfo'].first['extmetadata']['LicenseUrl']['value'].gsub('http:','https:') if pages.first['imageinfo'].first['extmetadata']['LicenseUrl']
      if categories.include? 'CC-PD-Mark'
        licence = 'CC-PD-Mark'
        licence_url = 'https://creativecommons.org/publicdomain/mark/1.0'
      end
      licence_url = 'https://en.wikipedia.org/wiki/Public_domain' if licence == 'Public domain' && licence_url == nil
      party = HTTParty.get(descriptionurl, :verify => false)
      doc = Nokogiri::HTML(party.to_s)
      an = doc.xpath('//span[@id="creator"]')
      author_name = an[0].content if !an.empty?
      if an.empty?
        an = doc.xpath('//tr[td/@id="fileinfotpl_aut"]/td')
        author_name = an[1].content if !an.empty? && an.size > 0
      end
      author_name = Sanitize.clean(author_name)
      author_name.gsub!('The original uploader was ','')
      author_name.gsub!(' at English Wikipedia','')
      author_url = ""
      au = doc.xpath('//span[@id="creator"]/*/a/@href')
      au = doc.xpath('//tr[td/@id="fileinfotpl_aut"]/td/a/@href') if au.empty?
      author_url = au[0].content if !au.empty? && au.size > 0
      author_url = "https://commons.wikimedia.org" + author_url if author_url.start_with?('/wiki/User:')
      description = ""
      description_element = doc.xpath('//td[@class="description"]')
      description = Sanitize.clean(description_element[0].content)[0,255].strip! if description_element.size > 0

      geohack = doc.xpath("//a[contains(@href, 'tools.wmflabs.org/geohack')]/@href")
      longitude = geohack[0] ? /params=.*_[NS]_(-*\d*.\d*)/.match(geohack[0].value)[1] : nil
      latitude = geohack[0] ? /params=(\d*.\d*)/.match(geohack[0].value)[1] : nil

      openplaques_url = doc.xpath("//a[contains(@href, 'openplaques.org/plaques')]/@href")
      openplaques_id = openplaques_url[0] ? /plaques\/(\d*)/.match(openplaques_url[0].value)[1] : nil

      page_url = "https://commons.wikimedia.org/wiki/"+title
      {
        categories:  categories,
        url:         pages.first['imageinfo'].first['url'],
        page_url:    page_url,
        description: description,
        author:      author_name,
        author_url:  author_url,
        licence:     licence,
        licence_url: licence_url,
        longitude:   longitude,
        latitude:    latitude,
        openplaques_id: openplaques_id
      }
    end

    private

      def json_get(uri)
        response = HTTParty.get(uri, :verify => false)
        if response.code == 200
          JSON.parse(response.body)
        else
          raise Exception.new("bad status code from Wikimedia server (#{response.code}):\n#{response.body}")
        end
      end

      def uri_for(params)
        "#{@uri}?#{URI.encode_www_form(params)}"
      end

      def search_uri(query)
        uri_for action: 'opensearch', search: query, limit: 100
      end

      def query_uri(term)
        uri_for action: 'query', titles: term, prop: 'images', format: 'json'
      end

      def info_uri(image)
        uri_for action: 'query', titles: image, prop: 'imageinfo|categories', iiprop: 'url|extmetadata', format: 'json'
      end

      def category_uri(term)
        uri_for action: 'query', list: 'categorymembers', format: 'json', cmtitle: term
      end

      def default_uri
        @default_uri ||= "https://commons.wikimedia.org/w/api.php"
      end

    end
end
