# skips length validations, more permissive defaults
class Hostname2Validator < PAK::ValidatesHostname::HostnameValidator

  def initialize(options)
    opts = {
      :allow_underscore        => true,
      :require_valid_tld       => false,
      :valid_tlds              => PAK::ValidatesHostname::ALLOWED_TLDS,
      :allow_numeric_hostname  => true,
      :allow_wildcard_hostname => false
    }.merge(options)
    super(opts)
  end

  def validate_each(record, attribute, value)
    value ||= ''

    # split each hostname into labels and do various checks
    if value.is_a?(String)
      labels = value.split '.'
      labels.each_with_index do |label, index|

        # CHECK 2: hostname label cannot begin or end with hyphen
        add_error(record, attribute, :label_begins_or_ends_with_hyphen) if label =~ /^[-]/i or label =~ /[-]$/

        # Take care of wildcard first label
        next if options[:allow_wildcard_hostname] and label == '*' and index == 0

        # CHECK 3: hostname can only contain characters:
        #          a-z, 0-9, hyphen, optional underscore, optional asterisk
        valid_chars = 'a-z0-9\-'
        valid_chars << '_' if options[:allow_underscore] == true
        add_error(record, attribute, :label_contains_invalid_characters, :valid_chars => valid_chars) unless label =~ /^[#{valid_chars}]+$/i
      end

      # CHECK 4: the unqualified hostname portion cannot consist of
      #          numeric values only
      if options[:allow_numeric_hostname] == false
        is_numeric_only = (
          (
            Integer(labels[0]) rescue false
          ) ? true : false
        )
        add_error(record, attribute, :hostname_label_is_numeric) if is_numeric_only
      end

      # CHECK 5: in order to be fully qualified, the full hostname's
      #          TLD must be valid
      if options[:require_valid_tld] == true
        has_tld = options[:valid_tlds].select {
          |tld| tld =~ /^#{Regexp.escape(labels.last || '')}$/i
        }.empty? ? false : true
        add_error(record, attribute, :hostname_is_not_fqdn) unless has_tld
      end
    end
  end

end
