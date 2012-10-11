require 'sinatra'
require 'sinatra/sequel'

set :database, 'sqlite://foo.db'

Sequel::Model.plugin :validation_helpers

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
migration "create pages" do
  database.create_table :pages do
    primary_key :id
    text        :name
    text        :url
  end
end

migration "create page widgets" do
  database.create_table :page_widgets do
    primary_key :id
    integer     :page_id
    text        :js_class
    title       :text
  end
end

migration "create role" do
  database.create_table :roles do
    primary_key :id
    foreign_key :user_id
    text        :role
  end
end

Dir.glob(File.expand_path(File.dirname(__FILE__)) + '/../app/models/*.{rb,class}') {|file| require file}
