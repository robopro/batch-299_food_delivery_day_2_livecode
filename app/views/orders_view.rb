class OrdersView
  def display(orders)
    orders.each do |order|
      puts "#{order.id}. #{order.customer.name} | #{order.meal.name} | #{order.employee.username}"
    end
  end

  def display_employees(employees)
    print `clear`
    employees.each_with_index do |employee, index|
      puts "#{employee.id}. #{employee.username}"
    end
  end
end
