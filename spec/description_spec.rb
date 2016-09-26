require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #description' do
    context 'of a deleted photo' do
      it 'should be "missing"' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Vancouver_-_Gastown_Steam_Clock_plaque.jpg'
          expect(image[:description]).to eq 'missing'
        end
      end
    end

    context 'of a Delhi portrait of a man' do
      it 'should be there' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
        image = Wikimedia::Commoner.details 'File:India_-_Delhi_portrait_of_a_man_-_4780.jpg'
          expect(image[:description]).to include 'English: Portrait of a man, Delhi, India.'
        end
      end
    end
  end
end
