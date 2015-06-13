require_relative 'bundle/bundler/setup'
require 'sinatra'
require "sinatra/json"
require 'stripe'
require 'slack'
require 'rest'
require 'rest-client'

set :bind, '0.0.0.0'
set :port, 8080
set :public_folder, 'public'

set :slack_subdomain, ENV['SLACK_SUBDOMAIN']
set :slack_token, ENV['SLACK_API_TOKEN']
set :slack_channel, ENV['SLACK_CHANNEL']

slack = Slack::Client.new(:token => settings.slack_token)
puts 'auth'
user_info = slack.auth_test
p user_info

get "/" do
  erb :index
end

def parse(request)
  p request.body.rewind
  js = JSON.parse(request.body.read)
  p js
  js
end

post "/invite" do
  js = parse(request)
  email = js["email"]
  channel = js["channel"]
  # rest = Rest::Client.new
  # use secret endpoint
  r = RestClient.post "https://#{settings.slack_subdomain}.slack.com/api/users.admin.invite",
                      {
                          :email => email,
                          :channel => channel,
                          :token => settings.slack_token
                      }
  p r
  p r.code
  jsr = JSON.parse(r.body)
  p jsr
  if jsr["ok"]
    jsr["msg"] = "dunno"
    json jsr
    return
  end
  status 400
  jsr["msg"] = jsr["error"]
  p jsr
  json jsr
end

get '/ping' do
  "pong"
end

# Health checked for gce
get '/_ah/health' do
  "pong"
end

get '/_ah/start' do
  "pong"
end