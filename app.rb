require 'sinatra'
require "sinatra/reloader" if development?
require "haml"

class MyApp < Sinatra::Base

  configure do
    enable :sessions
    require "./db/config.rb"
    set :root, File.dirname(__FILE__)
    set :views, settings.root + '/app/views'
    register Sinatra::Reloader
  end

  get '/' do
    haml :index
  end

  #get '/foo' do
  #  session[:message] = 'Hello World!'
  #  redirect '/bar'
  #end

  #get '/bar' do
  #  raise session[:message].inspect   # => 'Hello World!'
  #end

  get     '/users' do

  end

  get     '/users/:id' do |id|
    @user = User.find(id)
    raise @user.inspect
  end

  post    '/users' do

  end

  put     '/users/:id' do |id|

  end

  delete  '/users/:id' do |id|

  end

end
