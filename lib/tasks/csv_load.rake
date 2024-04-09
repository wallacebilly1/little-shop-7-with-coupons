require 'csv'

namespace :csv_load do
  desc "seed customers csv data"
  task :customers => :environment do
    file_path = "db/data/customers.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    puts "Customers seeded successfully"
  end

  desc "seed merchants csv data"
  task :merchants => :environment do
    file_path = "db/data/merchants.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    puts "Merchants seeded successfully"
  end

  desc "seed items csv data"
  task :items => :environment do
    file_path = "db/data/items.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    puts "Items seeded successfully"
  end

  desc "seed invoices csv data"
  task :invoices => :environment do
    file_path = "db/data/invoices.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    puts "Invoices seeded successfully"
  end
  
  desc "seed transactions csv data"
  task :transactions => :environment do
    file_path = "db/data/transactions.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    puts "Transactions seeded successfully"
  end

  desc "seed invoice_items csv data"
  task :invoice_items => :environment do
    file_path = "db/data/invoice_items.csv"
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    puts "InvoiceItems seeded successfully"
  end

  desc "destroy all database data"
  task :destroy_all => :environment do
    Transaction.destroy_all
    InvoiceItem.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    Merchant.destroy_all
    Item.destroy_all
    puts "All Databases have been destroyed"
  end

  desc "seed all csv data"
  task :all => :environment do
    Rake::Task["csv_load:destroy_all"].invoke
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:transactions"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
  end
end
