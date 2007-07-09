class Book < ActiveRecord::Base
  validates_presence_of :title, :author_id
  
  belongs_to :author
end