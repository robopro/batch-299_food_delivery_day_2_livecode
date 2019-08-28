require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @meals = []
    @next_id = 1
    load_csv if File.exists?(@csv_path)
  end

  def all
    @meals
  end

  def add(meal)
    # 1. Give id to meal instance
    meal.id = @next_id
    # 2. add meal to meals array
    @meals << meal
    # 3. save to csv
    save_csv
    # 4. Increment ID
    @next_id += 1
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    @next_id = @meals.last.id + 1 unless @meals.empty?
  end

  def save_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id name price]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
