namespace :db do

  desc 'Create sample data from db/samples.rb'
  task :samples => :environment do
    samples_file = File.join(Rails.root, "db", "samples.rb")
    load(samples_file) if File.exist?(samples_file)
  end

end
