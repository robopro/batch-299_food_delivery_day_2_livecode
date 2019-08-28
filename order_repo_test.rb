require_relative "app/repositories/meal_repository"
require_relative "app/repositories/employee_repository"
require_relative "app/repositories/customer_repository"
require_relative "app/repositories/order_repository"

@meal_repo = MealRepository.new("data/meals.csv")
@employee_repo = EmployeeRepository.new("data/employees.csv")
@customer_repo = CustomerRepository.new("data/customers.csv")
@order_repo = OrderRepository.new("data/orders.csv", @meal_repo, @employee_repo, @customer_repo)

# p order_repo

# You can run `irb` and write `require_relative 'order_repo_test'`
# If you do you'll have access to the @order_repo in `irb`

# Or you can set up byebug in the OrderRepository inside the #load_csv method.
# If you run this script it you can then debug the load_csv code and inspect
# how the conversion of strings from the CSV get "transformed" into the
# instance objects we want.

# And, of course, you can write you own tests in here, like always ^^
