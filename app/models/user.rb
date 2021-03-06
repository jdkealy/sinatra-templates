class User < Sequel::Model
  def self.crud_attributes
    ['email', 'name','username']
  end
  one_to_many :roles

  require 'bcrypt'

  def self.possible_roles
    [:admin, :user]
  end

  def before_save
    if password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      self.password = ''
    end
  end

  def validate
    validates_presence  [:password,:email] if new?
    validates_unique    [:email]
  end

  def self.authenticate(email, password)
    user = User.find(:email=>email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def in_role?(role)
    self.roles.map{|r| r.role}.include? role.to_s
  end
end
