Sequel::Model.plugin :validation_helpers
class User < Sequel::Model
  require 'bcrypt'
  def before_save
    if password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      self.password = ''
    end
  end

  def validate
    validates_presence  [:password,:email]
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
end
