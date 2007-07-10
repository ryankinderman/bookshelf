require File.dirname(__FILE__) + '/model_test_helper'

class AuthorTest < Test::Unit::TestCase
  
  def test_initialize
    author = Author.new(params)
    assert author.valid?
  end
  
  def test_invalid_without_first_name
    author = Author.new(params.delete_if { |k,v| k == :first_name })
    assert !author.valid?
  end
  
  def test_invalid_without_last_name
    author = Author.new(params.delete_if { |k,v| k == :last_name })
    assert !author.valid?    
  end
  
  def test_full_name
    author = Author.new(params(:last_name => "Kinderman", :first_name => "Ryan"))
    assert_equal "Kinderman, Ryan", author.full_name
  end
  
  def test_to_s
    author = Author.new(params)
    assert_equal author.full_name, author.to_s
  end
  
  def test_books
    author = Author.create!(params)
    
    assert author.books.empty?
    
    author.books << create(:book)
    
    assert !author.books[0].new_record?
    
    author = Author.find(author.id)
    
    assert_equal 1, author.books.length
  end
  
  private
  
  def params(differences={})
    author_params(differences)
  end
  
end