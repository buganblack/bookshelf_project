Rails.application.routes.draw do
  resources :bookshelves do
    collection do
      get "bookshelf_records", to: "bookshelves#bookshelf_records"
    end
  end
  resources :books
end
