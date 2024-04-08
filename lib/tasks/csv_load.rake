require 'csv'

namespace :import do
  desc "Import data from CSV"
  task csv: :environment do