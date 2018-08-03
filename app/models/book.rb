class Book < ActiveRecord::Base
  validates :name, :author_name, :rating, presence: true
  validates :bookshelves_count, presence: { message: "Choose at least 1 bookshelf" }
  validates :rating, numericality: { message: "Rating should be a number" }
  validates_uniqueness_of :name, case_sensitive: true, message: "Book Name already exist"
end
