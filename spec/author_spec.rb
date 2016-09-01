require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #author' do
    context 'of a Delhi portrait of a man' do
      it 'should be Jorge Royan' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:India_-_Delhi_portrait_of_a_man_-_4780.jpg'
          expect(image[:author]).to eq 'Jorge Royan'
        end
      end
    end
    context 'of Nahal Zaror, south 11' do
      it 'should be Daniel Baránek' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:author]).to eq 'Daniel Baránek'
        end
      end
    end
    context 'of The mohave desert near the fossil beds' do
      it 'should be Unknown' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:PSM_V86_D252_The_mohave_desert_near_the_fossil_beds.jpg'
          expect(image[:author]).to eq 'Unknown'
        end
      end
    end
    context 'of a Spanish Civil War mass grave' do
      it 'should be Mario Modesto Mata' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Spanish_Civil_War_-_Mass_grave_-_Estépar,_Burgos.jpg'
          expect(image[:author]).to eq 'Mario Modesto Mata'
        end
      end
    end
    context 'of August Wilhelm von Hofmann' do
      it 'should be Unknown' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:author]).to eq 'Unknown'
        end
      end
    end
    context 'of Catherine of Aragon portrait' do
      it 'should be Lucas Hornebolte' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Catherine_aragon.jpg'
          expect(image[:author]).to eq 'Lucas Hornebolte'
        end
      end
    end
    context 'of Stepan Blois portrait' do
      it 'should be Matthew Paris' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Stepan_Blois.jpg'
          expect(image[:author]).to eq 'Matthew Paris'
        end
      end
    end
  end
end
