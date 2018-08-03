class BookshelvesController < ApplicationController
  def index
    @bookshelf_record = []
    if params[:search].present?
      @bookshelf_record = Bookshelf.find_by_id(extract_data)
    end
  end

  def create
    bookshelf = Bookshelf.new(bookshelf_params)
    if bookshelf.save
      flash["notice"] = "Bookshelf Created Successfully"
    end
    redirect_to bookshelves_path
  end

  def edit
    bookshelf = Bookshelf.find_by_id(params["id"])
    if bookshelf.update_attributes(bookshelf_params)
      flash[:notice] = "Update Successful"
    else
      flash[:error] = "Something went wrong please try again"
    end
    redirect_to :back
  end

  def destroy
    begin
      bookshelf = Bookshelf.find_by_id(params["id"])
      shelf_book_count(bookshelf.book_ids)
      bookshelf.delete
    rescue
      flash[:error] = "Something went wrong please try again"
    else
      flash[:notice] = "Successfully deleted bookshelf"
    end
    redirect_to bookshelves_path
  end

  private

  def shelf_book_count(shelf_ids)
    shelf_ids.each do |b_id|
      book = Book.find(b_id)
      book.bookshelves_count -= 1
      book.bookshelves_count.zero? ? book.delete : book.save
    end
  end

  def extract_data
    params[:search][:sort_by].present? ? params[:search][:description_id] : params[:search].values.first
  end

  def bookshelf_params
    params.require(:bookshelf).permit(:title, :description)
  end
end
