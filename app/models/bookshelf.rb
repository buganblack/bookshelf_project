class Bookshelf < ActiveRecord::Base
  serialize :book_ids, Array
  validates :title, presence: { message: "Bookshelf Title must not be empty" }
  validates :description, presence: { message: "Please add description for the bookshelf" }
end
