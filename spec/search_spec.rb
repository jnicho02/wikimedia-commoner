require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'doing a #search' do
    context 'on an unknown term' do
      it 'should find nothing' do
        VCR.use_cassette ('searching/' + self.class.description).gsub(" ","-") do
          titles = Wikimedia::Commoner.search 'badger'
          expect(titles).to eq([])
        end
      end
    end
    context 'on a known term' do
      it 'should find some titles' do
        VCR.use_cassette ('searching/' + self.class.description).gsub(" ","-") do
          titles = Wikimedia::Commoner.search 'Meles meles'
          expect(titles.size).to be > 0
        end
      end
    end
  end
end
