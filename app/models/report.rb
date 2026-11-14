class Report < ApplicationRecord
  belongs_to :user
  belongs_to :location
  before_save :provide_date
  has_many_attached :report_images
  validate :acceptable_image
  ACCEPTABLE_SIZE = 3.megabytes
  ACCEPTABLE_TYPE = %w[ image/jpeg image/png image/webp ].freeze

  private
  def provide_date
    self.report_date = Date.today if self.report_date.blank?
  end

  def acceptable_image
    return unless report_images.attached?
    report_images.each do |image|
      unless ACCEPTABLE_TYPE.include?(image.blob.content_type)
        errors.add(:report_images, "image must be either jpg, png, webp")
      end
    end

    report_images.each do |image|
      unless image.blob.byte_size <= ACCEPTABLE_SIZE
        errors.add(:report_images, "image size must be less than 3MB")
      end
    end
  end
end
