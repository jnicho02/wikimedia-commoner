require 'spec_helper'

describe Wikimedia::Commoner do

  describe '#author' do
    context 'of a Delhi portrait of a man' do
      it 'is Jorge Royan' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:India_-_Delhi_portrait_of_a_man_-_4780.jpg'
          expect(image[:author]).to eq 'Jorge Royan'
        end
      end
    end
    context 'of Nahal Zaror, south 11' do
      it 'is Daniel Baránek' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:author]).to eq 'Daniel Baránek'
        end
      end
      it 'is linked to Daniel Baránek wikimedia user page' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:author_url]).to eq 'http://commons.wikimedia.org/wiki/User:Daniel_Bar%C3%A1nek'
        end
      end
    end
    context 'of The mohave desert near the fossil beds' do
      it 'is unknown' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:PSM_V86_D252_The_mohave_desert_near_the_fossil_beds.jpg'
          expect(image[:author]).to eq 'Unknown'
        end
      end
    end
    context 'of a Spanish Civil War mass grave' do
      it 'is Mario Modesto Mata' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Spanish_Civil_War_-_Mass_grave_-_Estépar,_Burgos.jpg'
          expect(image[:author]).to eq 'Mario Modesto Mata'
        end
      end
    end
    context 'of August Wilhelm von Hofmann' do
      it 'is unknown' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:author]).to eq 'Unknown'
        end
      end
      it 'is not linked to an author url' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:author_url]).to eq ''
        end
      end
    end
    context 'of Catherine of Aragon portrait' do
      it 'is Lucas Hornebolte' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Catherine_aragon.jpg'
          expect(image[:author]).to eq 'Lucas Hornebolte'
        end
      end
    end
    context 'of Stepan Blois portrait' do
      it 'is Matthew Paris' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Stepan_Blois.jpg'
          expect(image[:author]).to eq 'Matthew Paris'
        end
      end
      it 'is linked to Matthew Paris Wikipedia page' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Stepan_Blois.jpg'
          expect(image[:author_url]).to eq '//en.wikipedia.org/wiki/Matthew_Paris'
        end
      end
    end
  end

end
