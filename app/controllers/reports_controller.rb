# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: :show
  before_action :set_current_user_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:comments)
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    report = Report.new(report_params)

    if report.save
      redirect_to report_url(report)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to report_url(@report)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def set_current_user_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content).merge(user_id: current_user.id)
  end
end
