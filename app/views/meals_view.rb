class MealsView
  def display(meals)
    print `clear`
    meals.each do |meal|
      puts "#{meal.id}. #{meal.name} - $#{meal.price}"
    end
  end

  def ask_for(attribute)
    puts "What is the #{attribute}?"
    gets.chomp
  end
end
