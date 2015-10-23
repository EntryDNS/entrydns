module Users::AuthenticationsHelper
  def authentication_provider_column(record, column)
    case record.provider
    when 'google_oauth2'
      ret = <<-DOC
        <span class="btn btn-block btn-social btn-google-plus">
          <i class="fa fa-google-plus"></i> Google
        </span>
      DOC
      ret.html_safe
    else
      record.provider.camelcase
    end
  end
end
