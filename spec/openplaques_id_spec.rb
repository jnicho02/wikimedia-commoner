require 'spec_helper'

describe Wikimedia::Commoner do

  describe '#openplaques_id' do

    context 'the Sir Harold Gillies plaque' do
      it 'has an Open Plaques id' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:SIR_HAROLD_GILLIES_1882-1960_Pioneer_Plastic_Surgeon_lived_here.jpg'
          expect(image[:openplaques_id]).to eq '259'
        end
      end
    end

    context 'photo of Stanley Osher' do
      it 'does not have an Open Plaques id' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Stanley_Osher.jpg'
          expect(image[:openplaques_id]).to eq nil
        end
      end
    end

  end

end
