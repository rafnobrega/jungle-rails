require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    it "should not save without a valid name" do
      @category = Category.new
      product = Product.new(name: nil, price: 1991, quantity: 9119, category: @category)
      expect(product).to_not be_valid
    end
    
    it "should not save without a valid price" do
      @category = Category.new
      product = Product.new(name: "Rafael", price: false, quantity: 9119, category: @category)
      expect(product).to_not be_valid
    end

    it "should not save without a valid quantity" do
      @category = Category.new
      product = Product.new(name: "Rafael", price: 1991, quantity: nil, category: @category)
      expect(product).to_not be_valid
    end

    it "should not save without a valid category" do
      @category = Category.new
      product = Product.new(name: "Rafael", price: 1991, quantity: 9119, category: nil)
      expect(product).to_not be_valid
    end

    it "should save if all fields are valid" do
      @category = Category.new
      product = Product.new(name: "Rafael", price: 1991, quantity: 9119, category: @category)
      expect(product).to be_valid
    end
  
  end
end
