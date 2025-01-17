require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end

  describe 'instance methods' do
    it 'returns all ingredients a chef uses' do
      @chef = Chef.create!(name: "Gordon Ramsey")

      @dish = Dish.create!(name: "Beef Wellington", description: "A delightful beef lightly coated", chef_id: @chef.id)
      @dish2 = Dish.create!(name: "Fetuccine", description: "light but creamy", chef_id: @chef.id)

      @beef = Ingredient.create!(name: 'beef tenderloin', calories: 125)
      @flour = Ingredient.create!(name: 'flour', calories: 15)
      @cream = Ingredient.create!(name: 'cream', calories: 45)
      @pasta = Ingredient.create!(name: 'pasta', calories: 200)

      DishIngredient.create!(dish: @dish, ingredient: @beef)
      DishIngredient.create!(dish: @dish, ingredient: @flour)
      DishIngredient.create!(dish: @dish2, ingredient: @cream)
      DishIngredient.create!(dish: @dish2, ingredient: @pasta)
      DishIngredient.create!(dish: @dish2, ingredient: @flour)

      expect(@chef.all_ingredients).to eq([@beef, @flour, @cream, @pasta])
    end
  end
end
