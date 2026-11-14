class User < ApplicationRecord
  has_one :location
  has_many :reports, dependent: :nullify
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :mobile_number, phone: true, allow_blank: false
  before_save :normalize_mobile_number

  private
  def normalize_mobile_number
    return unless mobile_number
    self.mobile_number = Phonelib.parse(mobile_number).full_e164.presence
  end
end
