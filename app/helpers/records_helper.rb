module RecordsHelper
  def record_authentication_token_column(record)
    record.type == 'A' ? record.authentication_token : '-'
  end
end