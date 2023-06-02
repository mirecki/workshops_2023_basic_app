require 'rails_helper'

RSpec.describe WeatherPresenter do
  let(:weather_data) do
    double(:weather_data,
           description: description,
           location: location,
           temperature: temperature,
           icon: icon)
  end

  let(:description) { nil } # But we start with blank data for our first scenario
  let(:location) { nil }
  let(:temperature) { nil }
  let(:icon) { nil }

  subject(:link_meta_presenter) { described_class.new(weather_data) } # Subject is an instance of our presenter

  describe '#weather_data' do
    it 'returns the weather_data' do
      expect(subject.weather_data).to be weather_data # Make sure article gets initialised correctly
    end
  end

  describe '#og_type' do # Our first two specs are the same in all scenarios
    it 'returns article by default in all cases' do
      expect(subject.og_type).to eq 'article'
    end
  end

  describe '#domain' do
    it 'returns happybearsoftware.com by default in all cases' do
      expect(subject.domain).to eq 'happybearsoftware.com'
    end
  end

  context 'when the article has a Twitter card' do # First scenario
    let(:twitter_card) do # We swap our our articles nil twitter card for this let
      double(:twitter_card,
             card: 'twitter_card_summary',
             title: 'Twitter title',
             description: 'Twitter description',
             image_url: 'twitter.com/image',
             creator: '@twitter_card_author',
             site: 'twitter.com/site')
    end

    describe '#card_type' do
      it 'returns the card type defined by the Twitter card' do
        expect(subject.card_type).to eq 'twitter_card_summary' # Ensures the first condition 'twitter_card&.card' is what's returned
      end
    end

    describe '#title' do
      it 'returns the title defined by the Twitter card' do
        expect(subject.title).to eq 'Twitter title'
      end
    end

    describe '#description' do
      it 'returns the description defined by the Twitter card' do
        expect(subject.description).to eq 'Twitter description'
      end
    end

    describe '#image_url' do
      it 'returns the image url defined by the Twitter card' do
        expect(subject.image_url).to eq 'twitter.com/image'
      end
    end

    describe '#creator' do
      it 'returns the creator defined by the Twitter card' do
        expect(subject.creator).to eq '@twitter_card_author'
      end
    end

    describe '#site' do
      it 'returns the site defined by the Twitter card' do
        expect(subject.site).to eq 'twitter.com/site'
      end
    end
  end

  context 'when the article has no Twitter card' do
    let(:twitter_card) { nil } # This isn't necessary as we defined it nil at the top, but is nice to remind us what's different

    context 'when all the article fields are present' do
      let(:title) { 'Title' } # Again we swap out the data with what our new scenario needs
      let(:html_title) { 'HTML Title' }
      let(:description) { 'Description' }
      let(:author) { double(:author, twitter_url: 'https://twitter.com/twitter_username') }

      describe '#title' do
        context 'when there is an html title' do
          let(:html_title) { 'HTML Title' }

          it 'returns the html title of the article' do
            expect(subject.title).to eq 'HTML Title'
          end
        end

        context 'when there is no html title' do
          let(:html_title) { nil }

          it 'returns the title of the article' do
            expect(subject.title).to eq 'Title'
          end
        end
      end

      describe '#description' do
        it 'returns the article description' do
          expect(subject.description).to eq 'Description' 
        end
      end

      describe '#image_url' do
        it 'returns the default image' do
          expect(subject.image_url).to eq 'https://images.ctfassets.net/jdiiwrjwwj2y/47bceGNtJuAAOYQc6gMI2e/2437282b0d09fdacb515e222d7db21f5/Developers-guide-human-networking-Twitter.png'
        end
      end

      describe '#creator' do
        it "returns the author's Twitter username" do
          expect(subject.creator).to eq '@twitter_username'
        end
      end

      describe '#site' do
        it "returns the company Twitter username" do
          expect(subject.site).to eq '@happybearsoft'
        end
      end
    end

    context 'when the article is missing data' do
      let(:title)       { nil }
      let(:html_title)  { nil }
      let(:description) { nil }
      let(:author)      { nil }

      describe '#title' do
        it 'returns the site title' do
          expect(subject.title).to eq 'Happy Bear Software | Ruby on Rails Development Agency'
        end
      end

      describe '#description' do
        it 'returns the site description' do
          expect(subject.description).to eq 'Happy Bear Software is a technical consultancy that helps businesses build better custom software on the web. We use Ruby on Rails and JavaScript.'
        end
      end

      describe '#image_url' do
        it 'returns the default image' do
          expect(subject.image_url).to eq 'https://images.ctfassets.net/jdiiwrjwwj2y/47bceGNtJuAAOYQc6gMI2e/2437282b0d09fdacb515e222d7db21f5/Developers-guide-human-networking-Twitter.png'
        end
      end

      describe '#creator' do
        it "returns the company's Twitter username" do
          expect(subject.creator).to eq '@happybearsoft'
        end
      end

      describe '#site' do
        it "returns the company Twitter username" do
          expect(subject.site).to eq '@happybearsoft'
        end
      end
    end
  end
end
