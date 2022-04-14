# frozen_string_literal: true

class Books::CommentsController < ApplicationController
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
    comment = Comment.find(params[:id])
    return if current_user != comment.user
    comment.destroy
    redirect_to book_url(id: params[:book_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commentable_type, :commentable_id).merge(user_id: current_user.id)
  end
end
