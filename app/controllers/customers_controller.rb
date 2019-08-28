require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # 1. Gets the customers from the customer_repository
    customers = @customer_repository.all
    # 2. Passes the customers to the view display method
    @customers_view.display(customers)
  end

  def add
    # 1. Ask user for name
    name = @customers_view.ask_for("name")
    # 2. Ask user for price
    address = @customers_view.ask_for("address")
    # 3. Create a customer with name and address
    customer = Customer.new(name: name, address: address)
    # 4- Send customer to customer_repository
    @customer_repository.add(customer)
    # 5. List all meals so user can see the change
    list
  end
end
