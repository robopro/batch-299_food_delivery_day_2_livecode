require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # 1. Ask for username
    username = @sessions_view.ask_for("username")
    # 2. Ask for password
    password = @sessions_view.ask_for("password")
    # 3. Check that user with username exists
    employee = @employee_repository.find_by_username(username)
    # 4. Check if password given is same as in employee_repository
    if employee && employee.password == password
      @sessions_view.welcome
      employee
    else
      # give a message ("wrong credentials")
      @sessions_view.wrong_credentials
      # try again
      login # Recursive call
    end
  end
end
