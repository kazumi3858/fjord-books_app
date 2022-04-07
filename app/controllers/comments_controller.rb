# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.save
    redirect_to request.referer
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commentable_type, :commentable_id).merge(user_id: current_user.id)
  end
end
