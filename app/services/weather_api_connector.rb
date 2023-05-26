class WeatherApiConnector
  API_KEY = A9n.weather_api_key
  getIPUrl = 'http://ip-api.com/json/';
  ipUri = URI(getIPUrl)
  responseIp = Net::HTTP.get(ipUri)
  LOCATION = JSON.parse(responseIp)['city'].freeze

  def weather_data
    url = "http://api.weatherapi.com/v1/current.json?key=#{API_KEY}&q=#{LOCATION}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
