require 'sinatra'
require "sinatra/reloader" if development?
require "haml"

class MyApp < Sinatra::Base

  configure do
    require "./db/config.rb"
    set :root, File.dirname(__FILE__)
    set :views, settings.root + '/app/views'
    register Sinatra::Reloader
  end

  get '/' do
    haml :index
  end

end
