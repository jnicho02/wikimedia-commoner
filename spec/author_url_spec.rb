require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #author_url' do
    context 'of Nahal Zaror, south 11' do
      it 'should link to Daniel Baránek\'s wikimedia user page' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:author_url]).to eq 'http://commons.wikimedia.org/wiki/User:Daniel_Bar%C3%A1nek'
        end
      end
    end
    context 'of August Wilhelm von Hofmann' do
      it 'should not link to anything' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:author_url]).to eq ''
        end
      end
    end
    context 'of Stepan Blois portrait' do
      it 'should link to Matthew Paris\'s Wikipedia page' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Stepan_Blois.jpg'
          expect(image[:author_url]).to eq '//en.wikipedia.org/wiki/Matthew_Paris'
        end
      end
    end
  end
end
