module Users::RecordsHelper
  def record_authentication_token_column(record, column)
    record.type == 'A' ? record.authentication_token : '-'
  end
end
