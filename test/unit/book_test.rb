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
  
  def test_invalid_without_author
    book = Book.new(params.delete_if { |k,v| k == :author_id })
    assert !book.valid?    
  end
  
  def test_author
    book = Book.new(params)
    book.author = Author.create!(:first_name => "Billy", :last_name => "Bob")
    
    book.save!
    book.reload
    
    assert_not_nil book.author_id
    assert_equal book.author_id, book.author.id 
  end
  
  private
  
  def params(differences={})
    book_params(differences)
  end
  
end