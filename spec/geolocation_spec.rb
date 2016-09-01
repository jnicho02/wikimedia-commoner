require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #geolocation' do
    context 'of the Fog Gun plaque' do
      it 'should be latitude 53.316793' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:The_Fog_Gun_plaque_-_geograph.org.uk_-_159927.jpg'
          expect(image[:latitude]).to eq '53.316793'
        end
      end
      it 'should be longitude -4.666098' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:The_Fog_Gun_plaque_-_geograph.org.uk_-_159927.jpg'
          expect(image[:longitude]).to eq '-4.666098'
        end
      end
    end
  end
end
