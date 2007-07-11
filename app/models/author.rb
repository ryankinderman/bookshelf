class Author < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_many :book_authors
  has_many :books, :through => :book_authors
  
  def full_name
    last_name + ", " + first_name
  end
  
  def to_s
    full_name
  end
end