module Core::ResponseFormatter

  attr_accessor :response

  def request_success(args = {})
    {
      success: true
    }.merge! args
  end

  def request_failed(args = {})
    {
      success: false,
      status_code: args[:status_code],
      message: args[:message]
    }.compact
  end
end