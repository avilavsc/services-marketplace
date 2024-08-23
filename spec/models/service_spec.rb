require 'rails_helper'

RSpec.describe Service, type: :model do
  describe "Ransack search" do
    before do
      @user = User.create!(email: "user@example.com", password: "password")
      @service1 = Service.create!(title: "Fotografia", description: "Serviço de fotografia profissional", price: 150.00, user: @user)
      @service2 = Service.create!(title: "Consultoria", description: "Serviço de consultoria empresarial", price: 300.00, user: @user)
      @service3 = Service.create!(title: "Fotografia de eventos", description: "Fotografia para eventos", price: 200.00, user: @user)
    end

    it "returns services matching the title" do
      q = Service.ransack(title_cont: "Fotografia")
      results = q.result
      expect(results).to include(@service1, @service3)
      expect(results).not_to include(@service2)
    end

    it "returns services matching the title or description" do
      q = Service.ransack(title_or_description_cont: "evento")
      results = q.result

      expect(results).to include(@service3)
      expect(results).not_to include(@service1, @service2)
    end
  end

  describe "Model validations" do
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
end
