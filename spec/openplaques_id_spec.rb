require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #openplaques_id' do
    context 'of the Sir Harold Gillies plaque' do
      it 'should be id 259' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:SIR_HAROLD_GILLIES_1882-1960_Pioneer_Plastic_Surgeon_lived_here.jpg'
          expect(image[:openplaques_id]).to eq '259'
        end
      end
    end
    context 'of the photo of Stanley Osher' do
      it 'should be nil' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Stanley_Osher.jpg'
          expect(image[:openplaques_id]).to eq nil
        end
      end
    end
  end
end
