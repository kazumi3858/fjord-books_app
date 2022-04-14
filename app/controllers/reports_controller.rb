# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.includes(:comments)
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit
    redirect_to report_url(@report) if current_user != @report.user
  end

  def create
    report = Report.new(report_params)

    if report.save
      redirect_to report_url(report)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return if current_user != @report.user
    if @report.update(report_params)
      redirect_to report_url(@report)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return if current_user != @report.user
    @report.destroy

    redirect_to reports_url
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content).merge(user_id: current_user.id)
  end
end
