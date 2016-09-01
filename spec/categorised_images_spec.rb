require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'listing the #categorised_images' do
    context 'of a base category' do
      it 'should list images categorised as this and within subcategories' do
        VCR.use_cassette ('categorised_images/' + self.class.description).gsub(" ","-") do
          images = Wikimedia::Commoner.categorised_images 'Category:Stolperstein-Plagiate'
        end
      end
    end
  end
end
