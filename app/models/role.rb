class Role < Sequel::Model
  many_to_one :user
  def self.crud_attributes
    ['role', 'user_id']
  end
end
