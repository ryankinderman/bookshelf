class Book < ActiveRecord::Base
  validates_presence_of :title
  
  has_many :book_authors
  has_many :authors, :through => :book_authors
  
  def author_ids=(author_ids)
    self.book_authors = author_ids.collect { |id| BookAuthor.new(:author_id => id) }
  end
  
  def author_ids
    self.book_authors.collect { |book_author| book_author.author_id }
  end
    
end