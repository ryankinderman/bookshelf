require File.dirname(__FILE__) + '/../test_helper'

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
    author = Author.new(:first_name => "Ryan", :last_name => "Kinderman")
    assert_equal "Kinderman, Ryan", author.full_name
  end
  
  def test_to_s
    author = Author.new(:first_name => "Ryan", :last_name => "Kinderman")
    assert_equal author.full_name, author.to_s
  end
  
  private
  
  def params(differences={})
    {
      :first_name => "First",
      :last_name => "Last"
    }.merge(differences)
  end
  
end