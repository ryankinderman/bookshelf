require File.dirname(__FILE__) + '/../test_helper'

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
    book = Book.new(params.delete_if { |k,v| k == :author })
    assert !book.valid?    
  end
  
  private
  
  def params(differences={})
    {
      :title => "Test Title",
      :author => "Test Author"
    }.merge(differences)
  end
  
end