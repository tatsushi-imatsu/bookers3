class PostCommentsController < ApplicationController

def create
    @book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = @book.id
   respond_to do |format|
     if comment.save
      format.html { redirect_to request.referer }
      format.js { render :show }
     else
      format.html { redirect_to request.referer }
     end
   end
end

  def destroy
    comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
    @book = comment.book
    comment.destroy
    render :show
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
