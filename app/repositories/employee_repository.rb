require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_path)
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def all_delivery_guys
    @employees.reject { |employee| employee.manager? }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
    @next_id = @employees.last.id + 1 unless @employees.empty?
  end
end
