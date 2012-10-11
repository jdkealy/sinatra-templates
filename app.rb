require 'sinatra'
require "sinatra/reloader" if development?
require "haml"
require 'sinatra/backbone'

class MyApp < Sinatra::Base

  def redirect_url
    '/'
  end

  configure do
    enable :sessions
    require "./db/config.rb"
    set :root, File.dirname(__FILE__)
    set :views, settings.root + '/app/views'
    register Sinatra::Reloader
    require "./app/rest/auth"
    require "./app/rest/users"
    require "./app/cms/system_pages"
    require "./app/rest/pages"
    register Sinatra::JstPages
    also_reload "./app/models/*"
    also_reload "./app/rest/auth.rb"
    serve_jst '/jst.js'
  end

  get '/' do
    haml :index
  end
end
