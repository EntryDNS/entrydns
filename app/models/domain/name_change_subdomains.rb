class Domain < ActiveRecord::Base
  attr_accessor :apply_subdomains

  def apply_subdomains=(v)
    @apply_subdomains = ActiveRecord::ConnectionAdapters::Column.value_to_boolean(v)
  end

  before_update do
    self.parent = parent_domain if name_changed? # recompute parent
  end

  after_update do
    (apply_subdomains ? chain_rename : sync_orphan_children) if name_changed?
  end

  protected

  # previous subdomains in the system for the previous domain name
  # in case of domain name change
  def previous_subdomains
    Domain.where(:name_reversed.matches => "#{name_reversed_was}.%")
  end

  # only immediate children
  def previous_children_subdomains
    descendants = previous_subdomains.preorder.all
    first = descendants.first
    return [] unless first.present?

    # only immediate children
    depth = first.depth
    descendants.select { |d| d.depth == depth }
  end

  # Syncs with nested interval when the parent is added later than the children
  def sync_orphan_children
    previous_children_subdomains.each do |subdomain|
      subdomain.parent = subdomain.parent_domain
      subdomain.save!
    end
  end

  # applies the tail rename to children
  def chain_rename
    name_was_pattern = /#{Regexp.escape(name_was)}$/
    previous_children_subdomains.each do |subdomain|
      subdomain.name = subdomain.name.sub(name_was_pattern, name)
      subdomain.apply_subdomains = true
      subdomain.save! # rest will chain recursively
    end
  end

end
