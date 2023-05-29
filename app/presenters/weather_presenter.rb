class WeatherPresenter
  def initialize(weather_data)
    @weather_data = weather_data
  end

  def description
    weather_data['current']['condition']['text']
  end

  def location
    weather_data['location']['name']
  end

  def temperature
    weather_data['current']['temp_c']
  end

  def icon
    weather_data['current']['condition']['icon']
  end

  def nice_weather?
    description == 'Sunny' || 'Partly cloudy'
  end

  def good_to_read_outside?
    nice_weather? && temperature > 15
  end

  def encourage_text
    if good_to_read_outside?
      'Get some snacks and go read a book in a park!'
    else
      "It's always a good weather to read a book!"
    end
  end

  private

  attr_reader :weather_data
end

# posluzylem sie https://www.rubyguides.com/2019/09/rails-patterns-presenter-service/, 
# wciaz mi sie nie podoba ze mam w zasadzie globalna metode w helperze bo robi sie z tego metoda globalna. 
# Przeniesienie tych 2 metod do samego presentera nie zadziala bo nie bedzie tego widziec w widoku chyba ze musze miec jakos nazwe widoku korespondujaca z presenterem.
