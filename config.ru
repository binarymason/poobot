require 'sinatra'

InvalidTokenError = Class.new(Exception)

post '/' do
  raise(InvalidTokenError) unless params[:token] == ENV['SLACK_TOKEN']
  "This is your params: #{params}"
end

get '/' do
  'running.'
end

run Sinatra::Application
