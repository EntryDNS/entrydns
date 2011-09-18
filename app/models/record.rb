class Record < ActiveRecord::Base
  set_inheritance_column { 'sti_type' }
  belongs_to :domain
end
