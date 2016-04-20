require 'spec_helper'

describe Wikimedia::Commoner do

  describe '#searching' do
    context 'on an unknown term' do
      it 'finds nothing' do
        VCR.use_cassette ('searching/' + self.class.description).gsub(" ","-") do
          titles = Wikimedia::Commoner.search 'badger'
          expect(titles).to eq([])
        end
      end
    end
    context 'on a known term' do
      it 'finds some titles' do
        VCR.use_cassette ('searching/' + self.class.description).gsub(" ","-") do
          titles = Wikimedia::Commoner.search 'Meles meles'
          expect(titles.size).to be > 0
        end
      end
    end
  end

  describe '#images' do
    context 'on a known term' do
      it 'finds at least one image' do
        VCR.use_cassette ('images/' + self.class.description).gsub(" ","-") do
        	images = Wikimedia::Commoner.images 'Meles meles'
          first = images[0]
          expect(first[:url].start_with?("https:")).to be(true)
        end
      end
    end
    context 'on an unknown term' do
      it 'finds nothing' do
        VCR.use_cassette ('images/' + self.class.description).gsub(" ","-") do
          images = Wikimedia::Commoner.images 'plaques'
          expect(images).to eq nil
        end
      end
    end
  end

  describe '#categorised_images' do
    context 'a base category' do
      it 'lists images categorised as this and within subcategories' do
        VCR.use_cassette ('categorised_images/' + self.class.description).gsub(" ","-") do
          images = Wikimedia::Commoner.categorised_images 'Category:Stolperstein-Plagiate'
        end
      end
    end
  end
end
