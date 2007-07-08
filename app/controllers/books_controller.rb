class BooksController < ApplicationController
  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = "Successfully created book '#{@book.title}''"
      redirect_to :action => 'index'
    else
      flash.now[:error] = "Errors were encountered while attempting to create the book"
      render :action => 'new'
    end
  end
end