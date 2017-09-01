require 'sinatra'
require 'httparty'

if ENV['RACK_ENV'] === 'development'
  require 'dotenv'
  Dotenv.load
end

InvalidTokenError = Class.new(Exception)
SLACK_WEBHOOK_URL = ENV.fetch('SLACK_WEBHOOK_URL')

post '/' do
  raise(InvalidTokenError) unless params[:token] == ENV['SLACK_TOKEN']
  message = params.fetch('text')
  return "need a message!" unless message

  payload = {
    channel: '@john.mason',
    username: 'PooBot',
    text: message,
    icon_emoji: ':poop:'
  }

  res = HTTParty.post(SLACK_WEBHOOK_URL, body: payload.to_json)

  if res.success?
    "sent! :+1:"
  else
    "ERROR!: #{res.body.inspect} | THIS WAS PAYLOAD: #{payload}"
  end
end

get '/' do
  'running.'
end

run Sinatra::Application

