require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # 1. Gets the meals from the meal_repository
    meals = @meal_repository.all
    # 2. Passes the meals to the view display method
    @meals_view.display(meals)
  end

  def add
    # 1. Ask user for name
    name = @meals_view.ask_for("name")
    # 2. Ask user for price
    price = @meals_view.ask_for("price").to_i
    # 3. Create a meal with name and price
    meal = Meal.new(name: name, price: price)
    # 4- Send meal to meal_repository
    @meal_repository.add(meal)
    # 5. List all meals so user can see the change
    list
  end
end
