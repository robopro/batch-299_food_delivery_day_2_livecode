require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_path)
  end

  def all
    @customers
  end

  def add(customer)
    # 1. Give id to customer instance
    customer.id = @next_id
    # 2. add customer to customers array
    @customers << customer
    # 3. save to csv
    save_csv
    # 4. Increment ID
    @next_id += 1
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end

  def save_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id name address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
