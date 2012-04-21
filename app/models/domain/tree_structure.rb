class Domain < ActiveRecord::Base
  attr_accessor :parent_synced
  
  # this goes before acts_as_nested_interval call
  before_save do
    self.name_reversed = name.reverse if name_changed?
    sync_parent
  end
  
  # this goes after sync_parent, to order callbacks correctly 
  acts_as_nested_interval virtual_root: true
  
  validate :domain_ownership
  def domain_ownership
    # non-TLD validation
    errors[:name] = "cannot be a TLD or a reserved domain" if Tld.include?(name)

    # If parent domain is on our system, the user be permitted to manage current domain.
    # He either owns parent, or is permitted to current domain or to an ancestor.
    if parent_domain.present? && !parent_domain.can_be_managed_by_current_user?
      @domain_ownership_failed = true
      errors[:name] = "issue, the parent domain `#{parent_domain.name}` is registered to another user"
    end
  end
  
  # If current user present authorize it
  # If current user not present, just allow (rake tasks etc)
  def can_be_managed_by_current_user?
    return true if User.current.nil?
    Ability::CRUD.all?{|operation| User.current.can?(operation, self)}
  end
  
  after_save :sync_children
  
  # Returns the first immediate parent, if exists (and caches the search)
  def parent_domain
    return nil if name.nil?
    @parent_domain ||= {}
    @parent_domain[name] ||= _parent_domain
  end
  
  def subdomains
    Domain.where(:name_reversed.matches => "#{name_reversed}.%")
  end
  
  def subdomain_of?(domain)
    name.end_with?('.' + domain.name)
  end
  
  def self.rebuild_nested_interval_tree!
    skip_callback :update, :before, :sync_children
    super
    set_callback :update, :before, :sync_children
  end
  
  protected

  # Returns the first immediate parent, if exists (does not cache the search)
  # For example "sub.sub.domain.com"'s parent might be "sub.domain.com" or "domain.com"
  def _parent_domain
    segments = name.split('.')
    while segments.size > 1
      segments.shift
      domain = Domain.find_by_name(segments.join('.'))
      return domain if domain.present?
    end
    return nil
  end
  
  # Syncs with nested interval when a child is added and parent exists
  def sync_parent
    if !@parent_synced && parent_domain.present? && self.parent_id != parent_domain.id
      self.parent = parent_domain
    end
  end

  # Syncs with nested interval when the parent is added later than the children
  def sync_children
    descendants = subdomains.preorder.all
    first = descendants.first
    return true unless first.present?
      
    # only immediate children, rest will chain recursively
    depth = first.depth
    descendants = descendants.select { |d| d.depth == depth }
      
    subdomains.each do |subdomain|
      subdomain.parent = self
      subdomain.parent_synced = true # no n+1
      subdomain.save!
    end
  end
  
end
