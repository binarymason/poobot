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
    channel: '#general-announcements',
    text: message,
    icon_emoji: ':poop:',
    username: 'PooBot'
  }

  HTTParty.post(SLACK_WEBHOOK_URL, body: payload)
  "sent! :+1:"
end

get '/' do
  'running.'
end

run Sinatra::Application
