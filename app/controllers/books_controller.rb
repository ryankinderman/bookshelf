class BooksController < ApplicationController
  def index
    initialize_index
  end
  
  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = "Successfully created book '#{@book.title}'"
      redirect_to_index
    else
      flash.now[:error] = "Errors occurred while attempting to create the book"
      render :action => 'new'
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      flash[:notice] = "Successfully updated book '#{@book.title}'"
      redirect_to_index
    else
      flash.now[:error] = "Errors occurred while attempting to update the book"
      render :action => 'edit'
    end
  end
  
  def destroy
    Book.delete(params[:id])
    flash.now[:notice] = "Successfully removed book"
  end
  
  private
  
  def redirect_to_index
    initialize_index
    redirect_to :action => 'index'    
  end
  
  def initialize_index
    @books = Book.find(:all)
  end
end