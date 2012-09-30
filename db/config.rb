require 'sinatra'
require 'sinatra/sequel'

set :database, 'sqlite://foo.db'

require './db/migrations.rb'

migration "create users table" do
  database.create_table :users do
    primary_key :id
    text        :name
    text        :username
    text        :password
    index       :username, :unique => true
  end
end

migration "everything's better with bling" do
  database.alter_table :foos do
    drop_column :baz
    add_column :bling, :float
  end
end

Dir.glob(File.expand_path(File.dirname(__FILE__)) + '/../app/models/*.{rb,class}') {|file| require file}
