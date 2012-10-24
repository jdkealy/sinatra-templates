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

  Sequel::Model.subclasses.each do |c|
    get "/restapi/#{c}" do
      c.all.map{|a| a.values}.to_json
    end

    post "/restapi/#{c}" do
      user = new c(params["#{c}"])
    end

    put "/restapi/#{c}/:id" do |id|
      user = c.find(:id=>id)
      user.update(params["#{c}"])
      user.save
    end

    get "/restapi/#{c}/:id" do |id|
      user = c.find(:id=>id)
      user.values.to_json
    end

    delete "/restapi/#{c}/:id" do |id|
      user = c.find(:id=>id)
      user.destroy
    end
  end
 

  get '/' do
    haml :index
  end
end
