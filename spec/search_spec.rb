require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'doing a #search' do
    context 'on an unknown term' do
      let(:titles) {
        VCR.use_cassette("searching/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.search('badger')
        }
      }
      it 'should find nothing' do
        expect(titles).to eq([])
      end
    end

    context 'on a known term' do
      let(:titles) {
        VCR.use_cassette("searching/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.search('Meles meles')
        }
      }
      it 'should find some titles' do
        expect(titles.size).to be > 0
      end
    end
  end
end
