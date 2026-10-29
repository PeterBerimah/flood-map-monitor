class Location < ApplicationRecord
  belongs_to :user
  has_many :reports
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
end
