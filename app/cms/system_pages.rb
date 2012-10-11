class MyApp < Sinatra::Base

  get '/admin', :auth => [:admin] do
    haml :admin
  end

  get '/admin/sign_in' do
  end

  get '/admin/sign_out' do
  end

end
