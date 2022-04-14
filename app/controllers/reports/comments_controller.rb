# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    report_id = comment_params[:commentable_id]
    if comment.save
      redirect_to report_url(id: report_id)
    else
      @report = Report.find(report_id)
      render 'reports/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    return if current_user != comment.user
    comment.destroy
    redirect_to report_url(id: params[:report_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :commentable_type, :commentable_id).merge(user_id: current_user.id)
  end
end
