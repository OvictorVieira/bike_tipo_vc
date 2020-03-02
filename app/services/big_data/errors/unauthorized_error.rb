class BigData::Errors::UnauthorizedError < StandardError

  def initialize
    super(I18n.t('big_data.error.unauthorized'))
  end
end