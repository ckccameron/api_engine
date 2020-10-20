desc "reset tables and import csv data"
task import: :environment do
  Customer.destroy_all
  Merchant.destroy_all
  Invoice.destroy_all
  Item.destroy_all
  InvoiceItem.destroy_all
  Transaction.destroy_all

  puts "All tables reset: Successful"

  require 'csv'

  CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Customer.create(row.to_h)
  end
  puts "Customers import: Successful"

  CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Merchant.create(row.to_h)
  end
  puts "Merchants import: Successful"

  CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    item = Item.create(row.to_h)
    item.unit_price = (row[:unit_price] / 100.00)
    item.save
  end
  puts "Items import: Successful"

  CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Invoice.create(row.to_h)
  end
  puts "Invoices import: Successful"

  CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    InvoiceItem.create(row.to_h)
  end
  puts "Invoice Items import: Successful"

  CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
    Transaction.create(row.to_h)
  end
  puts "Transactions import: Successful"

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  puts "Database data import: Successful"
end
