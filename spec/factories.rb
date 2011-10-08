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

  factory :soa_record, :class => 'SOA' do
    contact {Faker::Internet.email}
  end

  factory :ns_record, :class => 'NS' do
    content {Settings.ns.sample}
  end
  
end