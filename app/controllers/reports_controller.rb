class ReportsController < ApplicationController
  before_action :require_admin
  before_action :fetch_report

  def destroy
    @report.destroy
    redirect_to admin_reports_path, notice: 'Deleted Report'
  end

  private

  def fetch_report
    @report = Report.find_by(id: params[:id])
    redirect_to admin_reports_path, notice: 'Report does not exit' if @report.nil?
  end
end
