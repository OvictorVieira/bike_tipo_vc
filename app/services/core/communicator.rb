# frozen_string_literal: true
class Core::Communicator

  include Core::ResponseFormatter

  CONTENT_TYPE_JSON = 'application/json'

  attr_reader :end_point, :error_message

  def initialize(url_base, end_point)
    @url_base = url_base
    @end_point = end_point
  end

  def post(body, headers)
    response = HTTParty.post(mount_end_point, body: body.to_json, headers: headers)

    response_analyser(response)
  end

  private

  def mount_end_point
    @url_base + @end_point
  end

  def response_analyser(response)
    error_codes = Core::ResponseStatuses::ERROR_CODES.first

    return request_failed(status_code: error_codes[response.code]) if error_codes.include? response.code

    request_success
  end
end