class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
  end

  def run
    while @running
      @current_user = @sessions_controller.login
      while @current_user
        if @current_user.manager?
          display_manager_menu
          choice = gets.chomp.to_i
          print `clear`
          route_manager_action(choice)
        else
          display_delivery_guy_menu
          choice = gets.chomp.to_i
          print `clear`
          route_delivery_guy_action(choice)
        end
      end
    end
  end

  private

  def display_manager_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customer"
    puts "4 - Add a customer"
    puts "5 - List all undelivered orders"
    puts "6 - Add an order"
    puts "8 - Log out"
    puts "9 - Quit"
    print "> "
  end

  def display_delivery_guy_menu
    puts "------------------------------"
    puts "-------- DELIVERY GUY --------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all my undelivered order"
    puts "2 - Mark an order as delivered"
    puts "8 - Log out"
    puts "9 - Quit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 8 then @current_user = nil
    when 9 then stop
    else
      puts "Try again..."
    end
  end

  def route_delivery_guy_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@current_user)
    when 2 then @orders_controller.mark_as_delivered(@current_user)
    when 8 then @current_user = nil
    when 9 then stop
    else
      puts "Try again..."
    end
  end

  def stop
    @current_user = nil
    @running = false
  end
end
