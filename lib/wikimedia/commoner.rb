require "wikimedia/commoner/version"
require "httparty"
require "json"
require "sanitize"

module Wikimedia
  class Commoner
    def initialize(base_uri = nil)
      @uri = (base_uri) ? base_uri : default_uri
    end

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
      title = URI.decode_www_form_component title
      new.details(title)
    end

    def search(query)
      json_get(search_uri(query))[1]
    end

    def images(term)
      # get a list of titles for the given term
      response = json_get(query_uri(term))
      images = response["query"]["pages"].map { |page_id, page| page["images"] }
      if images != [ nil ]
        titles = images.flatten.map { |image| image["title"] }
        titles.map do |title|
          details(title)
        end
      end
    end

    def categorised_images(category)
      # get a list of titles for the given term
      response = json_get(category_uri(category))
      images = response["query"]["categorymembers"]
      if images!=[ nil ]
        titles = images.flatten.map { |image| image["title"] }
        titles.map { |title|
          if title.start_with?("Category:")
            categorised_images(title)
          else
            details(title)
          end
        }
      end
    end

    def pages(category)
      # get a list of titles for the given term
      response = json_get(category_uri(category))
      pages = response["query"]["categorymembers"]
      if pages!=[ nil ]
        titles = pages.flatten.map { |page| page["title"] }
        titles.map { |title|
          if title.start_with?("Category:")
            pages(title)
          else
            details(title)
          end
        }
      end
    end

    def details(title)
      m = /(File:[^#?]*)/.match(title)
      return nil unless m

      title = m[0]
      response = json_get(info_uri(title))
      return {} unless response

      pages = response["query"]["pages"].map { |page_id, page| page }
      return { description: "missing" } if pages.first["missing"]!=nil

      categories = pages.first["categories"].map { |category| category["title"] }.flatten
      categories = categories.map { |category| category.gsub(/^Category:/, "") }
      descriptionurl = pages.first["imageinfo"]&.first["descriptionurl"]
      extmetadata = pages.first["imageinfo"]&.first["extmetadata"]
      if extmetadata
        licence = extmetadata["LicenseShortName"]["value"] if extmetadata["LicenseShortName"]
        licence_url = extmetadata["LicenseUrl"]["value"].gsub("http:", "https:") if extmetadata["LicenseUrl"]
      end
      unless licence
        if categories.include? "CC-PD-Mark"
          licence = "CC-PD-Mark"
          licence_url = "https://creativecommons.org/publicdomain/mark/1.0"
        end
        if categories.include? "CC-BY-SA-4.0"
          licence = "CC-BY-SA-4.0"
          licence_url = "https://creativecommons.org/licenses/by-sa/4.0"
        end
      end
      if licence == "Public domain" && licence_url == nil
        licence_url = "https://creativecommons.org/publicdomain/mark/1.0"
      end
      party = HTTParty.get(descriptionurl, verify: false)
      doc = Nokogiri::HTML(party.to_s)
      an = doc.xpath('//span[@id="creator"]')
      author_name = an.empty? ? "" : an[0].content
      if an.empty?
        an = doc.xpath('//tr[td/@id="fileinfotpl_aut"]/td')
        author_name = an[1].content if !an.empty? && an.size > 0
      end
      author_name = Sanitize.fragment(author_name)
      author_name.gsub!("The original uploader was ", "")
      author_name.gsub!("Original uploader was ", "")
      author_name.gsub!(" at English Wikipedia", "")
      author_name.gsub!(" at en.wikipedia", "")
      author_name.gsub!("Photograph by ", "")
      author_name.gsub!("Engraving by ", "")
      author_url = ""
      au = doc.xpath('//span[@id="creator"]/*/a/@href')
      au = doc.xpath('//tr[td/@id="fileinfotpl_aut"]/td/a/@href') if au.empty?
      author_url = au[0].content if !au.empty? && au.size > 0
      if author_url.start_with?("/wiki/User:")
        author_url = "https://commons.wikimedia.org#{author_url}"
      end
      description = ""
      description_element = doc.xpath('//td[@class="description"]')
      description = Sanitize.fragment(description_element[0].content)[0, 255].strip! if description_element.size > 0

      longitude = doc.xpath("//a[contains(@class, 'mw-kartographer-maplink')]/@data-lon")[0]&.value
      latitude = doc.xpath("//a[contains(@class, 'mw-kartographer-maplink')]/@data-lat")[0]&.value
      wkt = "POINT(#{longitude} #{latitude})"

      openplaques_url = doc.xpath("//a[contains(@href, 'openplaques.org/plaques')]/@href")
      openplaques_id = openplaques_url[0] ? /plaques\/(\d*)/.match(openplaques_url[0].value)[1] : nil

      url = pages.first["imageinfo"].first["url"]

      page_url = "https://commons.wikimedia.org/wiki/#{title}"
      {
        categories:  categories,
        url:         url,
        page_url:    page_url,
        description: description,
        author:      author_name,
        author_url:  author_url,
        licence:     licence,
        licence_url: licence_url,
        longitude:   longitude,
        latitude:    latitude,
        openplaques_id: openplaques_id,
        wkt: wkt
      }
    end

    private

      def json_get(uri)
        response = HTTParty.get(uri, verify: false)
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
        uri_for action: "opensearch", search: query, limit: 100
      end

      def query_uri(term)
        uri_for action: "query", titles: term, prop: "images", format: "json"
      end

      def info_uri(image)
        uri_for action: "query", titles: image, prop: "imageinfo|categories", iiprop: "url|extmetadata", format: "json"
      end

      def category_uri(term)
        uri_for action: "query", list: "categorymembers", format: "json", cmtitle: term
      end

      def default_uri
        @default_uri ||= "https://commons.wikimedia.org/w/api.php"
      end
  end
end
