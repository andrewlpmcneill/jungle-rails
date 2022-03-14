require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'successfully creates a product when all validated' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: 'test', price_cents: 1000, quantity: 1, category: @category)
      expect(@product).to be_valid
    end
    it 'contains validation for name field' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: nil, price_cents: 1000, quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end
    it 'contains validation for price field' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: 'test', price_cents: nil, quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end
    it 'contains validation for quantity field' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: 'test', price_cents: 1000, quantity: nil, category: @category)
      expect(@product).to_not be_valid
    end
    it 'contains validation for category field' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: 'test', price_cents: 1000, quantity: 1, category: nil)
      expect(@product).to_not be_valid
    end
  end
end
