class Authentication < ActiveRecord::Base
  has_paper_trail

  belongs_to :user, :inverse_of => :authentications
end
