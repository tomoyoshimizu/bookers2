class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.all
    @side_bar = { user: current_user, form_value: Book.new }
    render layout: 'two_columns'
  end

  def create
    new_book = Book.new(book_params)
    new_book.user_id = current_user.id
    if new_book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(new_book.id)
    else
      @books = Book.all
      @side_bar = { user: current_user, form_value: new_book }
      render action: :index, layout: 'two_columns'
    end
  end

  def show
    @side_bar = { user: @book.user, form_value: Book.new }
    render layout: 'two_columns'
  end

  def edit
    @form_value = @book
  end

  def update
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      @form_value = @book
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = 'You have destroyed book successfully.'
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def is_matching_login_user
    user = @book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
