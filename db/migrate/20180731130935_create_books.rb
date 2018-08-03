class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string    :name, uique: true
      t.string    :author_name
      t.float     :rating
      t.integer   :bookshelves_count, null: false

      t.timestamps null: false
    end
    add_index :books, :bookshelves_count
  end
end
