class Page < Sequel::Model
  def self.crud_attributes
    ['title']
  end
end
