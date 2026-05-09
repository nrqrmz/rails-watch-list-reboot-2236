require 'uri'
require 'net/http'
require 'json'

url = URI("https://tmdb.lewagon.com/movie/top_rated")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'

response = http.request(request)
results = JSON.parse(response.read_body)['results']

results.each do |result|
  Movie.create!(
    title: result['title'],
    overview: result['overview'],
    rating: result['vote_average'].round(1),
    poster_url: "https://image.tmdb.org/t/p/original#{result['poster_path']}"
  )
end
