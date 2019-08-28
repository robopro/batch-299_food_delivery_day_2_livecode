class CustomersView
  def display(customers)
    print `clear`
    customers.each do |customer|
      puts "#{customer.id}. #{customer.name} - #{customer.address}"
    end
  end

  def ask_for(attribute)
    puts "What is the #{attribute}?"
    gets.chomp
  end
end
