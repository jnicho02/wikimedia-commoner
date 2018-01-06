require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #geolocation' do

    context 'the Kiln plaque' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('https://commons.wikimedia.org/wiki/File:The_Kiln_plaque.jpg')
        }
      }
      it 'has latitude' do
        expect(image[:latitude]).to eq('51.510364')
      end
      it 'has longitude' do
        expect(image[:longitude]).to eq('-0.211511')
      end
    end

  end
end
