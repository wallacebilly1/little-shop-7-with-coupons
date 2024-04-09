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
  
  desc "seed merchants csv data"
  task :merchants => :environment do
    file_path = "db/data/merchants.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_hash)
    end
    puts "Merchants seeded successfully"
  end

  desc "seed items csv data"
  task :items => :environment do
    file_path = "db/data/items.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_hash)
    end
    puts "Items seeded successfully"
  end

  desc "seed invoices csv data"
  task :invoices => :environment do
    file_path = "db/data/invoices.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_hash)
    end
    puts "Invoices seeded successfully"
  end
  
  desc "seed transactions csv data"
  task :transactions => :environment do
    file_path = "db/data/transactions.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_hash)
    end
    puts "Transactions seeded successfully"
  end

  desc "seed invoice_items csv data"
  task :invoice_items => :environment do
    file_path = "db/data/invoice_items.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    puts "InvoiceItems seeded successfully"
  end

  desc "seed all csv data"
  task :all => :environment do
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:transactions"].invoke
    Rake::Task["csv_load:invoice_items"].invoke

    # Rake::Task[:reset_primary_key].invoke
  end
end

desc "reset primary key..."
task :reset_primary_key => :environment do
  #code for resetting primary keys, avoiding duplicates
end
