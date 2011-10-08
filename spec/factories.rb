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
    association :soa_record, :factory => :soa_record, :method => :build
    ns_records do |ns_records| 
      ns1 = ns_records.association(:ns_record, :method => :build)
      ns2 = ns_records.association(:ns_record, :method => :build)
      ns1.content = Settings.ns.first
      ns2.content = (Settings.ns - [ns1.content]).sample
      [ns1, ns2]
    end
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