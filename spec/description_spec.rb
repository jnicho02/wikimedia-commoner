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
  end
end
