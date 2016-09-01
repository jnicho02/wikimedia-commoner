require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'listing the #images' do
    context 'of a known term' do
      it 'should find at least one image' do
        VCR.use_cassette ('images/' + self.class.description).gsub(" ","-") do
        	images = Wikimedia::Commoner.images 'Meles meles'
          first = images[0]
          expect(first[:url].start_with?("https:")).to be(true)
        end
      end
    end
    context 'of an unknown term' do
      it 'should find nothing' do
        VCR.use_cassette ('images/' + self.class.description).gsub(" ","-") do
          images = Wikimedia::Commoner.images 'plaques'
          expect(images).to eq nil
        end
      end
    end
  end
end
