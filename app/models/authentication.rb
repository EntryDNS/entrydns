class Authentication < ActiveRecord::Base
  belongs_to :user, :inverse_of => :authentications
end
