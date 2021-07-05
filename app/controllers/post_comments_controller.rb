class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.book_id = @book.id
    @post_comment.user_id = current_user.id
    if @post_comment.save
     render 'books/show'
    end
  end

  def destroy
		@book = Book.find(params[:book_id])
  	post_comment = @book.post_comments.find(params[:id])
		post_comment.destroy
		redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
