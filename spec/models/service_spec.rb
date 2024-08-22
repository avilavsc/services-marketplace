require 'rails_helper'

RSpec.describe Service, type: :model do
  it "is valid with valid attributes" do
    user = User.create(email: "test@example.com", password: "password")
    service = Service.new(title: "Web Design", description: "Design de sites", price: 100.0, user: user)
    expect(service).to be_valid
  end

  it "is not valid without a title" do
    service = Service.new(description: "Design de sites", price: 100.0)
    expect(service).not_to be_valid
  end
end
