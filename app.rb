require 'sinatra'
require 'chartkick'
require 'redis'

$redis = Redis.new(url: ENV['REDISCLOUD_URL'])

get '/' do
  @minutes   = $redis.get('minutes').to_i
  @ratings   = JSON.parse($redis.get 'ratings')
  @directors = JSON.parse($redis.get 'directors')
  @scores    = JSON.parse($redis.get 'scores')
  @years     = JSON.parse($redis.get 'years')
  @genres    = JSON.parse($redis.get 'genres')
  @images    = $redis.srandmember('images', 15)
  @votes     = JSON.parse($redis.get 'votes')

  erb :index, format: :html5
end

private

def format_number(num)
  # Is this seriously the only way?
  num.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
end