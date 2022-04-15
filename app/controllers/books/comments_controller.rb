# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  before_action :set_current_user_comment, only: :destroy

  def create
    comment = Comment.new(comment_params)
    book_id = comment_params[:commentable_id]
    if comment.save
      redirect_to book_url(id: book_id)
    else
      @book = Book.find(book_id)
      render 'books/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to book_url(id: params[:book_id])
  end

  private

  def set_current_user_comment
    @comment = Comment.find(params[:id])
    return if current_user == @comment.user

    render plain: '404 Not Found', status: :not_found
  end

  def comment_params
    params.require(:comment).permit(:comment, :commentable_type, :commentable_id).merge(user_id: current_user.id)
  end
end
