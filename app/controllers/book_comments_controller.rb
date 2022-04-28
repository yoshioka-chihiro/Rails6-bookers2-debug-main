class BookCommentsController < ApplicationController



  def create
    # コメントをする対象の投稿(travel_record)のインスタンスを作成
    @book = Book.find(params[:book_id])
    #投稿に紐づいたコメントを作成
    @book_comment = @book.book_comments.new(book_comment_params)
    # コメント投稿者(user)のidを代入
    @book_comment.user_id = current_user.id
    @book_comment.save
    @book = Book.find(params[:book_id])
    render :index
  end

   def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    render :index
   end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
