class Domain < ActiveRecord::Base

  before_validation(:on => :update) do
    if name_changed?
      name_was_pattern = /#{Regexp.escape(name_was)}$/
      each_update_involved_record do |record|
        if record.type == 'SOA'
          record.reset_serial
          record.name = name
        else
          record.name = record.name.sub(name_was_pattern, name)
        end
        record.domain = self
      end
    end
  end

  after_update do
    if name_changed?
      name_was_pattern = /#{Regexp.escape(name_was)}$/
      records.each do |record|
        record.name = record.name.sub(name_was_pattern, name)
        record.save!
      end
    end
  end

  def each_update_involved_record
    yield soa_record
    soa_records.each { |record| yield record }
    records.each     { |record| yield record }
  end

end
