# Validates IP addresses
#
# @author Kim Nørgaard <jasen@jasen.dk>
class IpValidator < ActiveModel::EachValidator

  IPV4_REGEX = /^
      (?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}
      (?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)
    $/x

  IPV6_REGEX = /^
      (
         (([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})
        |(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})
        |(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})
        |(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})
        |(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})
        |(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})
        |(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))
        |(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))
        |(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))
        |([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})
        |(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})
        |(([0-9A-Fa-f]{1,4}:){1,7}:)
      )$/x

  # @param [Hash] options Options for validation
  # @option options [Symbol] :ip_type (:any) The IP address type (:any, :v4 or :v6)
  # @see ActiveModel::EachValidator#new
  def initialize(options)
    options[:ip_type] ||= :any
    super
  end

  def validate_each(record, attribute, value)
    case options[:ip_type]
      when :v4
        record.errors.add(attribute, options[:message] || :ipv4) unless ipv4?(value)
      when :v6
        record.errors.add(attribute, options[:message] || :ipv6) unless ipv6?(value)
      else
        record.errors.add(attribute, options[:message] || :ip) unless ip?(value)
      end
  end
private
  # Validates IPv4 address
  # @param [String] address the ipv4 address
  # @return [Boolean] the validation result
  def ipv4?(address)
    address =~ IPV4_REGEX
  end

  # Validates IPv6 address
  # @param [String] address the ipv6 address
  # @return [Boolean] the validation result
  def ipv6?(address)
    address =~ IPV6_REGEX
  end

  # Validates IP (v4 or v6) address
  # @param [String] address the ip address
  # @return [Boolean] the validation result
  def ip?(address)
    ipv4?(address) || ipv6?(address)
  end
end
