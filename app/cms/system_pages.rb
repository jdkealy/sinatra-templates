class MyApp < Sinatra::Base

  get '/admin', :auth => [:admin] do
    haml :admin, :layout => :'admin/layout'
  end

 # get '/admin/resources', :auth => [:admin] do
 #     arr = []
 #     Sequel::Model.subclasses.each do |c|
 #     obj = {}
 #     obj[:class] = c
 #     obj[:association_reflection] = []
 #     if c.association_reflections 
 #       c.association_reflections.each do |k,v|
 #         new_obj = {
 #           :name         => k,
 #           :association  => v[:type],
 #           :class        => v[:class_name]
 #         }
 #         obj[:association_reflection] << new_obj
 #       end
 #     end
 #     arr << obj
 #   end
 #   arr.to_json
 # end

  get '/admin/resources', :auth => [:admin] do
      arr = []
      Sequel::Model.subclasses.each do |c|
      obj = {}
      obj[:class_name]      = c
      obj[:crud_attributes] = c.crud_attributes
      obj[:table] = c.simple_table
      obj[:schema] = c.db_schema
      obj[:association_reflection] = []
      if c.association_reflections 
        c.association_reflections.each do |k,v|
          new_obj = {
            :name         => k,
            :association  => v[:type],
            :class        => v[:class_name]
          }
          get "restapi/#{k}" do
            'hi'
          end
          obj[:association_reflection] << new_obj
        end
      end
      arr << obj
    end
      arr.to_json
  end

  get '/admin/sign_in' do
  end

  get '/admin/sign_out' do
  end

end
