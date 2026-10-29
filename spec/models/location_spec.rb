require 'rails_helper'

RSpec.describe Location, type: :model do
  let (:user) { User.create!(first_name: "Peter", last_name: "Abed-Odem", email: "peter@example.com", mobile_number: "0249226769", password: "secret", password_confirmation: "secret") }
  let (:location) { Location.create!(address: "Wisconsin International University College", user: user) }
  it { should belong_to(:user) }
end
