class CreateBookshelfs < ActiveRecord::Migration
  def change
    create_table :bookshelves do |t|
      t.string    :title, unique: true, null: false
      t.text      :description, null: false
      t.text      :book_ids

      t.timestamps null: false
    end
  end
end
