require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { User.create!(first_name: "Peter", last_name: "Abed-Odem", email: "peter@example.com", mobile_number: "0249226769", password: "secret", password_confirmation: "secret") }
  it "must have a first name" do
    user.first_name = nil
    expect(user).to_not be_valid
  end
  it "must have a last name" do
    user.last_name = nil
    expect(user).to_not be_valid
  end
  it "must have an email" do
    user.email = nil
    expect(user).to_not be_valid
  end
  it "must have a mobile number" do
    user.mobile_number = nil
    expect(user).to_not be_valid
  end
  it "phone number must be normalized before saved" do
    user.save!
    expect(user.mobile_number).to eq("+233249226769")
  end

  context "password" do
    it "must exist" do
      user.password = nil
      expect(user).to_not be_valid
    end
    it "length should not be less than 6" do
      user.password = "hello"
      user.password_confirmation = "hello"
      expect(user).to_not be_valid
    end
  end
end
