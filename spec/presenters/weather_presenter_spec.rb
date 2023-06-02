require 'spec_helper'
require 'rails_helper'

RSpec.describe WeatherPresenter do
  context 'when the weather_data has data' do
    subject(:presenter) { described_class.new(weather_data) }

    let(:weather_data) do
      { 'location' => { 'name' => 'Otrebusy', 'country' => 'Poland' },
        'current' => { 'last_updated_epoch' => 1_685_719_800,
                       'last_updated' => '2023-06-02 17:30',
                       'temp_c' => 14.0,
                       'temp_f' => 57.2,
                       'is_day' => 1,
                       'condition' => { 'text' => 'Partly cloudy',
                                        'icon' => '//cdn.weatherapi.com/weather/64x64/day/116.png', 'code' => 1003 } } }
    end

    describe '#description' do
      it 'returns the description from weather_data' do
        expect(presenter.description).to eq 'Partly cloudy'
      end
    end

    describe '#location' do
      it 'returns the location from weather_data' do
        expect(presenter.location).to eq 'Otrebusy'
      end
    end

    describe '#temperature' do
      it 'returns the temperature from weather_data' do
        expect(presenter.temperature).to eq 14.0
      end
    end

    describe '#icon' do
      it 'returns the icon from weather_data' do
        expect(presenter.icon).to eq '//cdn.weatherapi.com/weather/64x64/day/116.png'
      end
    end
  end

  context 'when the weather outside is good' do
    subject(:presenter) { described_class.new(weather_data) }

    let(:weather_data) do
      { 'location' => { 'name' => 'Otrebusy', 'country' => 'Poland' },
        'current' => { 'last_updated_epoch' => 1_685_719_800,
                       'last_updated' => '2023-06-02 17:30',
                       'temp_c' => 17.0,
                       'temp_f' => 57.2,
                       'is_day' => 1,
                       'condition' => { 'text' => 'Partly cloudy',
                                        'icon' => '//cdn.weatherapi.com/weather/64x64/day/116.png', 'code' => 1003 } } }
    end

    describe '#nice_weather?' do
      it 'returns true if description eq Sunny or Partially cloud' do
        expect(presenter.nice_weather?).to eq true
      end
    end

    describe '#good_to_read_outside?' do
      it 'returns true if temperature above 16 and nice_weather?' do
        expect(presenter.good_to_read_outside?).to eq true
      end
    end

    describe '#encourage_text' do
      it 'returns advice depending on weather condition' do
        expect(presenter.encourage_text).to eq 'Get some snacks and go read a book in a park!'
      end
    end
  end

  context 'when the weather outside is bad' do
    subject(:presenter) { described_class.new(weather_data) }

    let(:weather_data) do
      { 'location' => { 'name' => 'Otrebusy', 'country' => 'Poland' },
        'current' => { 'last_updated_epoch' => 1_685_719_800,
                       'last_updated' => '2023-06-02 17:30',
                       'temp_c' => 14.0,
                       'temp_f' => 57.2,
                       'is_day' => 1,
                       'condition' => { 'text' => 'Cloudy', 'icon' => '//cdn.weatherapi.com/weather/64x64/day/116.png',
                                        'code' => 1003 } } }
    end

    describe '#nice_weather?' do
      it 'returns true if description eq Sunny or Partially cloud' do
        expect(presenter.nice_weather?).to eq false
      end
    end

    describe '#good_to_read_outside?' do
      it 'returns true if temperature above 16 and nice_weather?' do
        expect(presenter.good_to_read_outside?).to eq false
      end
    end

    describe '#encourage_text' do
      it 'returns advice depending on weather condition' do
        expect(presenter.encourage_text).to eq 'It\'s always a good weather to read a book!'
      end
    end
  end
end
