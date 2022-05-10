class BooksController < ApplicationController

  before_action :authenticate_user!, expect: [:top]
  before_action :correct_user, only: [:top, :edit]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
  end

  def index
    if params[:option] == "A" || params[:option] == nil
     @books = Book.all.order(created_at: :desc)
    elsif params[:option] == "B"
     @books = Book.all.order(star: :desc)
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_name].split(',')
    if @book.save
      @book.save_tags(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @tag_list = @book.tags.pluck(:tag_name).join(',')
  end

  def update
    @book = Book.find(params[:id])
    @tag_list = params[:book][:tag_name].split(',')
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def correct_user
    #idのついた本を１つ選ぶ
    @book = Book.find(params[:id])
    #選んだ本をもってるUserであると定義
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
