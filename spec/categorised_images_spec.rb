require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'listing the #categorised_images' do
    context 'of a base category' do
      let(:images) {
        VCR.use_cassette("categorised_images/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.categorised_images('Category:Stolperstein-Plagiate')
        }
      }
      it 'should list images categorised as this and within subcategories' do
        expect(images).to be
      end
    end
  end
end
