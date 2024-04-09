require 'csv'

namespace :csv_load do
  desc "seed customers csv data"
  task :customers => :environment do
    file_path = "db/data/customers.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_hash)
    end
    puts "Customers seeded successfully"
  end
end