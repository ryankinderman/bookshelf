class Book < ActiveRecord::Base
  validates_presence_of :title
  
  has_many :book_authors
  has_many :authors, :through => :book_authors
  belongs_to :author
  
  def author_ids=(author_ids)
    @author_ids = author_ids
  end
  
  def after_save
    unless @author_ids.nil?
      self.book_authors.clear
      @author_ids.each_value { |author_id| self.authors << Author.find(author_id) }
      @author_ids = nil
    end
  end
end