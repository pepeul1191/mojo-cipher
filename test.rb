require 'sinatra'
require 'httparty'

get '/' do
    response = HTTParty.get('http://localhost:3000/')
    response.body
end