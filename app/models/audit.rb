class Audit < Audited::Adapters::ActiveRecord::Audit
  before_save do
    self.username = user.full_name if !username && user
  end
end