require 'spec_helper'

describe Wikimedia::Commoner do
  describe '#details' do
    context 'of a non-file page name' do
      it 'should give details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          images = Wikimedia::Commoner.details 'Meles meles'
        end
      end
    end
    context 'of a Commons file page' do
      it 'should give details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Badger 25-07-09.jpg'
        end
      end
      it 'should have a page url' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'File:Badger 25-07-09.jpg'
          expect(image[:page_url]).to eq 'https://commons.wikimedia.org/wiki/File:Badger 25-07-09.jpg'
        end
      end
    end
    context 'of a full Commons file page url' do
      it 'should give details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Badger 25-07-09.jpg'
        end
      end
    end
    context 'of a Wikipedia image preview url' do
      it 'should give details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://en.wikipedia.org/wiki/Main_Page#mediaviewer/File:Suillus_pungens_123004.jpg'
        end
      end
    end
    context 'of a Wikipedia mobile image preview url' do
      it 'should give details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://en.m.wikipedia.org/wiki/Main_Page#mediaviewer/File:Suillus_pungens_123004.jpg'
        end
      end
    end
    context 'of url with a strange character in' do
      it 'should give details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Jacobäerschild_in_Bautzen.JPG'
        end
      end
    end
    context 'of url for Jacob with unicode in' do
      it 'should give details of a title' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Jacob%C3%A4erschild_in_Bautzen.JPG'
        end
      end
    end
    context 'of a photo with extra bits on the end of the url' do
      it 'should give a description of "missing"' do
        VCR.use_cassette ('details/' + self.class.description).gsub(" ","-") do
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Plaque_in_Fortune_Street.jpg#.7B.7Bint:filedesc.7D.7D'
          expect(image[:page_url]).to eq 'https://commons.wikimedia.org/wiki/File:Plaque_in_Fortune_Street.jpg'
        end
      end
    end
  end
end
