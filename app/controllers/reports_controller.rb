class ReportsController < ApplicationController
  before_action :signed_in, except: [ :index ]
  before_action :correct_reporter, only: [ :edit, :update, :destroy ]
  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to reports_path, notice: "You have succesfully sent a report"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @report = Report.find(params[:id])
  end

  def edit
  end

  def update
    new_report_image =  params.dig(:report, :report_images)&.compact_blank
    @report.report_images.attach(new_report_image) if new_report_image.present?

    if @report.update(report_params.except(:report_images))
      redirect_to report_path, notice: "You have successfully updated your report"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @report.destroy
      redirect_to reports_path
    end
  end

  private

  def correct_reporter
    @report = Report.find(params[:id])
    unless @report.user == current_user
      redirect_to root_path
    end
  end

  def report_params
    params.require(:report).permit(:description, :report_date, :user_id, :location_id, report_images: [])
  end
end
