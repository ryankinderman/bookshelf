class Author < ActiveRecord::Base
  validates_presence_of :first_name, :last_name
  
  def full_name
    last_name + ", " + first_name
  end
  
  def to_s
    full_name
  end
end