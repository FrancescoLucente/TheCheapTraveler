# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Test delle validazioni
  it "is valid with a valid email and password" do
    user = User.new(email: "test@example.com", password: "securepassword")
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = User.new(password: "securepassword")
    expect(user).to_not be_valid
  end

  it "is invalid without a password" do
    user = User.new(email: "test@example.com")
    expect(user).to_not be_valid
  end

  
end
