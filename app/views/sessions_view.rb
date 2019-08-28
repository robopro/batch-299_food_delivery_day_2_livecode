class SessionsView
  def ask_for(attribute)
    puts "What is the #{attribute}?"
    gets.chomp
  end

  def welcome
    puts "You are logged in!"
  end

  def wrong_credentials
    puts "Wrong credentials... Try again!"
  end
end
