require 'spec_helper'

describe Wikimedia::Commoner do
  describe 'graphing OSM' do
    context 'categorised_images' do
      let(:images) {
        wc = Wikimedia::Commoner.new('https://wiki.openstreetmap.org/w/api.php')
        wc.categorised_images('Category:Maps of the United Kingdom')
      }
      it 'should find at least one image' do
        puts images
        expect(images).to be
      end
    end
  end
end
