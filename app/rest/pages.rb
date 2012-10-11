class MyApp < Sinatra::Base

  get     '/pages', :auth => [:user, :admin] do
    'iiwi'
  end
  get     '/pages/:id' do |id|
    @page = Page.find(id)
  end

  post    '/pages' do
  end

  put     '/pages/:id' do |id|
  end

  delete  '/pages/:id' do |id|
  end

end
