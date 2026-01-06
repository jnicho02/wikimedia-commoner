require 'spec_helper'

describe Wikimedia::Commoner do
  describe '#details' do
    context 'of a non-file page name' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.details('Meles meles')
        }
      }
      it 'should do nothing' do
        expect(image).to be_nil
      end
    end

    context 'of a Commons file page' do
      let(:image) {
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          Wikimedia::Commoner.details('File:Badger 25-07-09.jpg')
        }
      }
      it 'should give details of a title' do
        expect(image).to be
      end
      it 'should have a page url' do
        expect(image[:page_url]).to eq 'https://commons.wikimedia.org/wiki/File:Badger 25-07-09.jpg'
      end
    end

    context 'of a full Commons file page url' do
      it 'should give details of a title' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Badger 25-07-09.jpg'
          expect(image).to be
        }
      end
    end

    context 'of another url' do
      it 'should be nil' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://github.com/jnicho02/wikimedia-commoner/blob/master/lib/wikimedia/commoner/version.rb'
          expect(image).to be_nil
        }
      end
    end

    context 'of a Wikipedia image preview url' do
      it 'should give details of a title' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://en.wikipedia.org/wiki/Main_Page#mediaviewer/File:Suillus_pungens_123004.jpg'
          expect(image).to be
        }
      end
    end

    context 'of a Wikipedia mobile image preview url' do
      it 'should give details of a title' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://en.m.wikipedia.org/wiki/Main_Page#mediaviewer/File:Suillus_pungens_123004.jpg'
          expect(image).to be
        }
      end
    end

    context 'of url with a strange character in' do
      it 'should give details of a title' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Jacobäerschild_in_Bautzen.JPG'
          expect(image).to be
        }
      end
    end

    context 'of url for Jacob with unicode in' do
      it 'should give details of a title' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Jacob%C3%A4erschild_in_Bautzen.JPG'
          expect(image).to be
        }
      end
    end

    context 'of a photo with extra bits on the end of the url' do
      it 'should give a description of "missing"' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:Plaque_in_Fortune_Street.jpg#.7B.7Bint:filedesc.7D.7D'
          expect(image[:page_url]).to eq 'https://commons.wikimedia.org/wiki/File:Plaque_in_Fortune_Street.jpg'
        }
      end
    end

    context 'of a url with additional parameters' do
      it 'should give details of a title' do
        VCR.use_cassette("details/#{self.class.description}".gsub(" ", "-")) {
          image = Wikimedia::Commoner.details 'https://commons.wikimedia.org/wiki/File:MFC_Riverside_Exterior.JPG?uselang=en-gb'
          expect(image).to be
        }
      end
    end
  end
end
