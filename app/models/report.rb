class Report < ApplicationRecord
  belongs_to :user
  belongs_to :location
  before_save :provide_date
  has_one_attached :report_image

  private
  def provide_date
    if self.report_date.blank?
      self.report_date = Date.today
    end
  end
end
