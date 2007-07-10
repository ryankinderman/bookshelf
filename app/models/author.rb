class Author < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  
  has_many :books
  
  def full_name
    last_name + ", " + first_name
  end
  
  def to_s
    full_name
  end
end