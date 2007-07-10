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
  
  def test_can_set_authors_by_id
    book = create(:book)
    
    author1 = create(:author)
    book.author_ids = {"0" => author1.id}
    book.save!
    book = Book.find(book.id)
    
    assert_equal author1.id, book.authors[0].id
    
    author2 = create(:author)
    book.author_ids = {"0" => author2.id}
    book.save!
    book = Book.find(book.id)
    
    assert_equal 1, book.authors.length
    assert_equal author2.id, book.authors[0].id
  end
    
  private
  
  def params(differences={})
    book_params(differences)
  end
  
end