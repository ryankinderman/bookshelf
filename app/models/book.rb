class Book < ActiveRecord::Base
  validates_presence_of :title
  
  has_many :book_authors
  has_many :authors, :through => :book_authors
  
  def author_ids=(author_ids)
    self.book_authors = author_ids.collect { |id| BookAuthor.new(:author_id => id) }
  end
  
  def author_id=(value)
    self.book_authors = [BookAuthor.new(:author_id => value)]
  end
  
  def author_id
    book_authors.count == 0 ? nil : book_authors.first.author_id
  end
    
end