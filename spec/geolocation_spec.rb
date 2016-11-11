require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #geolocation' do

    context 'of the Fog Gun plaque' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('https://commons.wikimedia.org/wiki/File:The_Fog_Gun_plaque_-_geograph.org.uk_-_159927.jpg')
        }
      }
      it 'should be latitude 53.316793' do
        expect(image[:latitude]).to eq('53.316793')
      end
      it 'should be longitude -4.666098' do
        expect(image[:longitude]).to eq('-4.666098')
      end
    end
    
  end
end
