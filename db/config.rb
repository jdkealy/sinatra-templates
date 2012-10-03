require 'sinatra'
require 'sinatra/sequel'

set :database, 'sqlite://foo.db'

require './db/migrations.rb'

migration "create users" do
  database.create_table :users do
    primary_key :id
    text        :name
    text        :email
    text        :username
    text        :password
    text        :password_hash
    text        :password_salt
    index       :username, :unique => true
  end
end

Dir.glob(File.expand_path(File.dirname(__FILE__)) + '/../app/models/*.{rb,class}') {|file| require file}
