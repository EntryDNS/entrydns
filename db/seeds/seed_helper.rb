unless Object.const_defined?('FactoryGirl')
  require 'factory_girl'
  require 'faker'
  require Rails.root.join('spec', 'factories.rb')
end