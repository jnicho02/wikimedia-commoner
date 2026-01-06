require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'the #openplaques_id' do
    context 'of the Sir Harold Gillies plaque' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.details('File:SIR_HAROLD_GILLIES_1882-1960_Pioneer_Plastic_Surgeon_lived_here.jpg')
        }
      }
      it 'should be id 259' do
        expect(image[:openplaques_id]).to eq('259')
      end
    end

    context 'of the photo of Stanley Osher' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.details('File:Stanley_Osher.jpg')
        }
      }
      it 'should be nil' do
        expect(image[:openplaques_id]).to be_nil
      end
    end
  end
end
