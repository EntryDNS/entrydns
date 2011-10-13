FactoryGirl.define do
  
  sequence(:email){|n| "#{Faker::Internet.user_name}#{n}@example.com"}
  sequence(:password){|n| "password#{n}"}
  sequence(:domain_name){|n| "#{n}#{Faker::Internet.domain_name}"}
  
  factory :user do
    email
    password
    password_confirmation {password}
  end
  
  factory :domain do
    name {FactoryGirl.generate(:domain_name)}
    type 'NATIVE'
  end

  factory :record do
  end

  factory :soa do
    contact {Faker::Internet.email}
  end

  factory :ns do
    content {Settings.ns.sample}
  end

  factory :a do
    content {Faker::Internet.ip_v4_address}
  end
  
end
