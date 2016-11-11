require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #author' do

    context 'of a Delhi portrait of a man' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('https://commons.wikimedia.org/wiki/File:India_-_Delhi_portrait_of_a_man_-_4780.jpg')
        }
      }
      it 'should be Jorge Royan' do
        expect(image[:author]).to eq 'Jorge Royan'
      end
    end

    context 'of Nahal Zaror, south 11' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('File:Nahal_Zaror,_south_11.jpg')
        }
      }
      it 'should be Daniel Baránek' do
        expect(image[:author]).to eq('Daniel Baránek')
      end
      it 'should link to Daniel Baránek\'s wikimedia user page' do
        expect(image[:author_url]).to eq('https://commons.wikimedia.org/wiki/User:Daniel_Bar%C3%A1nek')
      end
    end

    context 'of The mohave desert near the fossil beds' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('File:PSM_V86_D252_The_mohave_desert_near_the_fossil_beds.jpg')
        }
      }
      it 'should be Unknown' do
        expect(image[:author]).to eq('Unknown')
      end
    end

    context 'of a Spanish Civil War mass grave' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('File:Spanish_Civil_War_-_Mass_grave_-_Estépar,_Burgos.jpg')
        }
      }
      it 'should be Mario Modesto Mata' do
        expect(image[:author]).to eq('Mario Modesto Mata')
      end
    end

    context 'of August Wilhelm von Hofmann' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('File:Hoffman_August_Wilhelm_von.jpg')
        }
      }
      it 'should be Unknown' do
        expect(image[:author]).to eq('Unknown')
      end
      it 'should not link to anything' do
        expect(image[:author_url]).to eq('')
      end
    end

    context 'of Catherine of Aragon portrait' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('File:Catherine_aragon.jpg')
        }
      }
      it 'should be Lucas Hornebolte' do
        expect(image[:author]).to eq('Lucas Hornebolte')
      end
    end

    context 'of Stepan Blois portrait' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ","-")) {
          Wikimedia::Commoner.details('https://commons.wikimedia.org/wiki/File:Stepan_Blois.jpg')
        }
      }
      it 'should be Matthew Paris' do
        expect(image[:author]).to eq('Matthew Paris')
      end
      it 'should link to Matthew Paris\'s Wikipedia page' do
        expect(image[:author_url]).to eq('//en.wikipedia.org/wiki/Matthew_Paris')
      end
    end

  end
end
