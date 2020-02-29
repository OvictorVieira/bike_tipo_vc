module BigData::Policies::RequestPolicy

  def request_unauthorized?(request_code)
    error_codes = Core::ResponseStatuses::ERROR_CODES

    request_code.eql? error_codes[Core::ResponseStatuses::UNAUTHORIZED]
  end
end