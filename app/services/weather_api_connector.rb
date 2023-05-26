class WeatherApiConnector
  API_KEY = A9n.weather_api_key
  get_ip_url = 'http://ip-api.com/json/'
  ip_uri = URI(get_ip_url)
  response_ip = Net::HTTP.get(ip_uri)
  LOCATION = JSON.parse(response_ip)['city'].freeze

  def weather_data
    url = "http://api.weatherapi.com/v1/current.json?key=#{API_KEY}&q=#{LOCATION}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
