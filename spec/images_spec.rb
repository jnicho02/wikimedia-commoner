require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'listing the #images' do
    context 'of a known term' do
      let(:images) {
        VCR.use_cassette("images/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.images('Meles meles')
        }
      }
      it 'should find at least one image' do
        expect(images[0][:url].start_with?("https:")).to be(true)
      end
    end

    context 'of an unknown term' do
      let(:images) {
        VCR.use_cassette("images/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.images('plaques')
        }
      }
      it 'should find nothing' do
        expect(images).to be_nil
      end
    end
  end
end
