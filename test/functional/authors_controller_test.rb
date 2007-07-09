require File.dirname(__FILE__) + '/controller_test_helper'

class AuthorsControllerTest < Test::Unit::TestCase
  
  def setup
    login_as :quentin
  end
  
  def test_that_index_renders_and_assigns
    get :index

    assert_renders 'index'
    assert_assigns :authors
  end
  
  def test_that_new_renders
    get :new

    assert_renders 'new'
  end
  
  def test_that_successful_create_redirects_to_index_with_flash_notice
    form_data = {:first_name => "William", :last_name => "Gibson"}
    author = stub(form_data.merge(:full_name => "Gibson, William"))
    Author.expects(:new).with(form_data.stringify_keys).returns(author)
    author.expects(:save).returns(true)
    
    post :create, :author => form_data
    
    assert_redirected :action => 'index'
    assert_flashes :notice
    assert_assigns :authors
  end
  
  def test_that_unsuccessful_create_rerenders_with_error
    form_data = {:last_name => "Gibson", :first_name => "William"}
    author = Author.new
    Author.expects(:new).with(form_data.stringify_keys).returns(author)
    author.expects(:save).returns(false)
    
    post :create, :author => form_data
    
    assert_renders 'new'
    assert_flashes :error, :now => true
  end
  
  def test_that_edit_renders_and_assigns
    author = Author.new
    author.stubs(:id).returns(123)
    Author.expects(:find).with('123').returns(author)
    
    get :edit, :id => 123
    
    assert_renders 'edit'
    assert_assigns :author
  end
  
  def test_that_successful_update_redirects_to_index_and_flashes_notice
    form_data = {:last_name => "Rice"}
    author = Author.new
    author.stubs(:full_name).returns("Rice, William")
    Author.expects(:find).with('123').returns(author)
    author.expects(:update_attributes).with(form_data.stringify_keys).returns(true)
    Author.expects(:find).with(:all).returns([])
    
    put :update, :id => 123, :author => form_data
    
    assert_redirected :action => 'index'
    assert_assigns :authors
    assert_flashes :notice
  end
  
  def test_that_unsuccessful_update_rerenders_and_flashes_error
    form_data = {:last_name => "Rice"}
    author = Author.new
    author.stubs(:id).returns(123)
    Author.expects(:find).with('123').returns(author)
    author.expects(:update_attributes).with(form_data.stringify_keys).returns(false)
    
    put :update, :id => 123, :author => form_data
    
    assert_renders 'edit'
    assert_assigns :author
    assert_flashes :error, :now => true
  end
  
  def test_that_destroy_redirects_to_index_and_flashes_notice
    Author.expects(:delete).with('123')
    
    delete :destroy, :id => 123
    
    assert_redirected :action => 'index'
    assert_assigns :authors
    assert_flashes :notice
  end

end