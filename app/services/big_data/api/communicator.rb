# frozen_string_literal: true
class BigData::Api::Communicator

  include BigData::Policies::RequestPolicy

  URL_BASE = 'https://springfield-biketipovc.herokuapp.com/'
  TRIPS_END_POINT = 'trips'

  def initialize(communication_base)
    @communication = communication_base
  end

  def post(body)
    request = @communication.post(body)

    raise BigData::Errors::UnauthorizedError if request_unauthorized?(request[:request_code])

    request
  end

end