require File.dirname(__FILE__) + '/model_test_helper'

class BookTest < Test::Unit::TestCase
  
  def test_initialize
    book = Book.new(params)
    assert book.valid?
  end
  
  def test_invalid_without_title
    book = Book.new(params.delete_if { |k,v| k == :title })
    assert !book.valid?
  end
  
#  def test_invalid_without_author
#    book = Book.new(params.delete_if { |k,v| k == :author_id })
#    assert !book.valid?
#  end
  
  def test_authors
    book = Book.create!(params)
    
    assert book.authors.empty?
    
    book.authors << create(:author)
    
    assert !book.authors[0].new_record?
    
    book = Book.find(book.id)
    
    assert_equal 1, book.authors.length    
  end
  
  def test_book_authors_setter
    book = create(:book)
    
    author1 = create(:author)
    
    book.book_authors = [BookAuthor.new(:author_id => author1.id)]
    
    book = Book.find(book.id)
    
    assert_equal 1, book.book_authors.size
  end

  def test_book_author_ids
    book = new(:book)
    
    author1 = create(:author)
    
    book.author_ids = [author1.id]
    book.save!
    
    book = Book.find(book.id)
    
    assert_equal author1.id, book.author_ids[0]
  end
  
  private
  
  def params(differences={})
    book_params(differences)
  end
  
end