require 'spec_helper'

describe Wikimedia::Commoner do

  describe '#licence' do
    context 'of a Delhi portrait of a man' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:India_-_Delhi_portrait_of_a_man_-_4780.jpg'
          expect(image[:licence]).to eq 'CC BY-SA 3.0'
        end
      end
    end
    context 'of Nahal Zaror, south 11' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:licence]).to eq 'CC BY-SA 3.0'
        end
      end
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Nahal_Zaror,_south_11.jpg'
          expect(image[:licence_url]).to eq 'http://creativecommons.org/licenses/by-sa/3.0'
        end
      end
    end
    context 'of The mohave desert near the fossil beds' do
      it 'is Creative Commons Attribution-Share Alike 3.0 Unported' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:PSM_V86_D252_The_mohave_desert_near_the_fossil_beds.jpg'
          expect(image[:licence]).to eq 'Public domain'
        end
      end
    end
    context 'of a Spanish Civil War mass grave' do
      it 'is Creative Commons Attribution-Share Alike 4.0 International' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Spanish_Civil_War_-_Mass_grave_-_Estépar,_Burgos.jpg'
          expect(image[:licence]).to eq 'CC BY-SA 4.0'
        end
      end
    end
    context 'of August Wilhelm von Hofmann' do
      it 'is public domain' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:licence]).to eq 'CC-PD-Mark'
        end
      end
    end
    context 'of August Wilhelm von Hofmann' do
      it 'is linked to a public domain' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Hoffman_August_Wilhelm_von.jpg'
          expect(image[:licence_url]).to eq 'http://creativecommons.org/publicdomain/mark/1.0'
        end
      end
    end
  end

end
