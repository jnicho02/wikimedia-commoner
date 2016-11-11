require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #description' do
    
    context 'of a deleted photo' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('https://commons.wikimedia.org/wiki/File:Vancouver_-_Gastown_Steam_Clock_plaque.jpg')
        }
      }
      it 'should be "missing"' do
        expect(image[:description]).to eq('missing')
      end
    end

    context 'of a Delhi portrait of a man' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('File:India_-_Delhi_portrait_of_a_man_-_4780.jpg')
        }
      }
      it 'should be there' do
        expect(image[:description]).to include('Portrait of a man, Delhi')
      end
    end

  end
end
