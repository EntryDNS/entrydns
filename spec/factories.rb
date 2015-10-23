FactoryGirl.define do

  sequence(:email){|n| "#{Faker::Internet.user_name}#{n}@example.com"}
  sequence(:password){|n| "password#{n}"}
  sequence(:domain_name){|n| "#{n}#{Faker::Internet.domain_name}"}
  sequence(:domain_word){|n| "#{n}#{Faker::Internet.domain_word}"}

  factory :user do
    full_name {Faker::Name.first_name + ' ' + Faker::Name.last_name}
    email
    password
    password_confirmation {password}
    after(:create) do |u|
      u.confirm!
    end
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
    name {FactoryGirl.generate(:domain_name)}
    content {Faker::Internet.ip_v4_address}
  end

  factory :permission do
  end

  factory :admin do
    email
    password
    password_confirmation {password}
  end

  factory :blacklisted_domain do
    name {FactoryGirl.generate(:domain_name)}
  end

end
