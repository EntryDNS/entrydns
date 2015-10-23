# Validates Zone objects
#
# @author Kim Nørgaard <jasen@jasen.dk>
class ZoneValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:mname, options[:message] || :mname) if mname_is_zone_name?(record)
    record.errors.add(:base,  options[:message] || :missing_ns_record) unless has_two_ns_rr?(record)
    record.errors.add(:mname, options[:message] || :not_a_defined_nameserver) unless mname_is_a_defined_nameserver?(record)
    record.errors.add(:base,  options[:message] || :duplicate_nameservers_found) unless nameservers_are_unique?(record)
  end

private
  # Check if the zone name equals the primary nameserver
  # @param [Zone] record The Zone to check
  # @return [Boolean] True if zone name and primary nameserver are identical
  def mname_is_zone_name?(zone)
    zone.name == zone.mname
  end

  # Check if the zone has at least two associated NS resource records
  # @param [Zone] zone The Zone to check
  # @return [Boolean] True if the zone has at least two associated NS resource records
  def has_two_ns_rr?(zone)
    zone.ns_resource_records.length >= 2
  end

  # Check if the primary nameserver of the zone is defined as one of the
  #   associated NS resource records
  # @param [Zone] zone The Zone to check
  # @return [Boolean] True if the primary nameserver is defined as one of the
  #   associated NS resource records
  def mname_is_a_defined_nameserver?(zone)
    unless zone.mname.blank?
      nameservers = zone.ns_resource_records.map(&:rdata)
      nameservers.select {|value| value.downcase == zone.mname.downcase}.size > 0
    end
  end

  # Check if the NS resource records of the zone are unique
  # @param [Zone] zone The Zone to check
  # @return [Boolean] True if the Zone has unique NS resource records associated
  def nameservers_are_unique?(zone)
    nameserver_data_fields = zone.ns_resource_records.map(&:rdata)
    nameserver_data_fields.inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.keys.empty?
  end
end
