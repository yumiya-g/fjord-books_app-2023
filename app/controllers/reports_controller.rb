# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
    @relationships = @report.reports_mentioned
  end

  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    if report_params.present?
      input_report_ids = extract_ids
      @report = current_user.reports.new(report_params)

      ActiveRecord::Base.transaction do
        @report.save!
        save_relationship(input_report_ids)
      end

      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if report_params.present?
      input_report_ids = extract_ids
      Relationship.where(mentioning_report_id: @report.id).destroy_all

      ActiveRecord::Base.transaction do
        @report.update!(report_params)
        save_relationship(input_report_ids)
      end
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)

    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def extract_ids
    report_params[:content].scan(%r{https?://localhost:3000/reports/(\d+)}).flatten.uniq
  end

  def save_relationship(input_report_ids)
    input_report_ids.map do |input_report_id|
      relationship = Relationship.new(mentioning_report_id: @report.id, mentioned_report_id: input_report_id)
      relationship.save!
    end
  end
end
