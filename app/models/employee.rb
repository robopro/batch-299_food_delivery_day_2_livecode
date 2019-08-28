class Employee
  attr_accessor :id
  attr_reader :username, :password, :role

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role] # manager / delivery_guy
    @orders = [] # We will store all the orders that an employee has
  end

  def manager?
    @role == "manager"
  end

  def delivery_guy?
    !manager?
  end

  # We can add orders to our @orders list, so the employee instance can keep track of it's orders.
  def add(order)
    order.employee = self # We make sure the order belongs to the employee before we add it
    @orders << order
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end
end
