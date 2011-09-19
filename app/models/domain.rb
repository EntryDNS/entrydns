class Domain < ActiveRecord::Base
  set_inheritance_column { 'sti_type' }
  has_many :records, :dependent => :destroy # :delete_all ?
end
