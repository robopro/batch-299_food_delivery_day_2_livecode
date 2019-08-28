require_relative '../views/orders_view'
require_relative '../views/meals_view'
require_relative '../views/customers_view'

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
  end

  # MANAGER ACTIONS
  def list_undelivered_orders
    # Get all undelivered orders from orders repo
    orders = @order_repository.undelivered_orders
    # Display undelivered orders to user
    @orders_view.display(orders)
  end

  # We need to display all the meals and let the user(manager) pick the one he wants
  # We needs to display all customers and let the user(manager) pick the one he wants
  # We need to display all delivery guys and let the user(manager) pick the one he wants
  # Then we can finally create a new Order instance, and add it to the order_repository
  def add
    meal = ask_user_for_meal # These are private methods. See towards the end of the file.
    customer = ask_user_for_customer
    employee = ask_user_for_delivery_guy

    order = Order.new(meal: meal, customer: customer, employee: employee)
    employee.add(order) # We need to link employee and order on both sides.

    @order_repository.add(order)
    list_undelivered_orders
  end

  # DELIVERY GUY ACTIONS
  def list_my_orders(current_user) # We pass the employee instance (current_user) from the router when we call this method.
    # We want to store a relationship between instances of Employee and instances of Order.
    # To do that we have added an @orders array to the Employee model, and a couple of methods.
    # Take a look at that class to figure out what's happening here.
    undelivered_orders = current_user.undelivered_orders
    @orders_view.display(undelivered_orders)
  end

  def mark_as_delivered(current_user)
    # We'll display all the undelivered orders of the current_user
    list_my_orders(current_user)
    # Then ask for an ID
    id = @meals_view.ask_for("id").to_i
    # Then call the mark_as_delivered method in the orders_repository
    # We do that so we don't have to expose the #save_csv method
    @order_repository.mark_as_delivered(id)
    # And finally we list the undelivered orders again so the user can see the change.
    list_my_orders(current_user)
  end

  private

  def ask_user_for_meal
    # Get all the meals from the meals repository
    meals = @meal_repository.all
    # We want to list all meals (send to view)
    @meals_view.display(meals)
    # And ask user to select and id/index
    id = @meals_view.ask_for("id").to_i
    # Then we find and return the meal in the repository.
    @meal_repository.find(id)
  end

  def ask_user_for_customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    id = @customers_view.ask_for("id").to_i
    @customer_repository.find(id)
  end

  def ask_user_for_delivery_guy
    delivery_guys = @employee_repository.all_delivery_guys
    @orders_view.display_employees(delivery_guys)
    # We can use the @meals_view. No need to create an #ask_for method in OrdersView.
    id = @meals_view.ask_for("id").to_i
    @employee_repository.find(id)
  end
end
