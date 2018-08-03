class BooksController < ApplicationController
  def create
    @books = Book.new(books_params)
    bookshelves = params["book"]["bookshelves_id"]
    @books.bookshelves_count = bookshelves.present? ? bookshelves.count : nil
    if @books.save
      shelves
      flash[:notice] = "Book Created Successfully"
      redirect_to bookshelves_path
    else
      render :new
    end
  end

  def destroy
    begin
      bookshelf = Bookshelf.find_by_id(params["bookshelf"])
      book = Book.find_by_id(params["id"])
      book.bookshelves_count -= 1
      bookshelf.book_ids.delete(book.id)
      book.bookshelves_count.zero? ? book.delete : book.save
      bookshelf.save
    rescue
      flash[:error] = "Something went wrong please try again"
    else
      flash[:notice] = "Successfully deleted book from bookshelf"
    end
    redirect_to :back
  end

  def edit
    book = Book.find_by_id(params["id"])
    if book.update_attributes(books_params)
      flash[:notice] = "Update Successful"
    else
      flash[:error] = "Something went wrong please try again"
    end
    redirect_to :back
  end

  private

  def shelves
    params["book"]["bookshelves_id"].keys.each do |bs_id|
      shelf = Bookshelf.find(bs_id)
      shelf.book_ids << @books.id
      shelf.save
    end
  end

  def books_params
    params.require(:book).permit(:name, :author_name, :rating, :bookshelves_count)
  end
end
