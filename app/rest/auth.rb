require 'omniauth'
require 'omniauth-google'
require 'omniauth-facebook'
require 'omniauth-twitter'
require 'omniauth-google-oauth2'
require 'omniauth-identity'

class MyApp < Sinatra::Base

  set(:auth) do |*roles|   # <- notice the splat here
    condition do
      unless logged_in? && roles.any? {|role| current_user.in_role? role }
        raise 'not logged in'.inspect
      end
    end
  end

  post '/authorizations' do
    u = User.authenticate(params['username'], params['password'])
    if u
      session[:user_id] = u.id
      redirect '/'
    else
      redirect '/sign_in'
    end
  end

  get '/auth' do
    if current_user
      current_user.values.to_json
    else
      {:code=>"not_signed_in", :message=>'not signed in'}.to_json
    end
  end


  get '/sign_in' do
    if current_user
      redirect redirect_url
    else
      haml :authorization
    end
  end

  get '/sign_up' do
  end

  get '/sign_out' do
    session[:user_id] = nil
    redirect '/sign_in'
  end

  def logged_in?
    current_user
  end

  def authorize!

  end

  def current_user
    if session[:user_id]
      u = User.find(:id=>"#{session[:user_id]}")
    else
      false
    end
  end

  post '/add_role', :auth => [:admin] do
    u = User.find(:id=>params['id'])
    u.add_role(:role=>params['role'])
  end

end
