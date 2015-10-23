# some common bits of code for records related controllers
module RecordsControllerCommon
  extend ActiveSupport::Concern

  included do
    before_filter :ensure_nested_under_domain
  end

  protected

  def before_create_save(record)
    record.domain = nested_parent_record
    record.user = record.domain_user
  end

  def nested_via_records?
    nested? && nested.association && nested.association.collection? &&
      nested.association.name == :records
  end

  # override to close create form after success
  # RecordsController is the only one that does not really need this
  def render_parent?
    nested_singular_association? # || params[:parent_sti]
  end
end
