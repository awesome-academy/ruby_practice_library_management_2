class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @book = Book.find_by(id: params[:book_id])
    @comment = @book.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.js
        format.html{redirect_to @book}
      end
    else
      respond_to do |format|
        format.js
        format.html do
          redirect_to @book, alert: "Có lỗi xảy ra khi thêm bình luận."
        end
      end
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @book = @comment.book

    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.js
        format.html{redirect_to @book}
      end
    else
      redirect_to @book, alert: "Bạn không có quyền xóa bình luận này."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
