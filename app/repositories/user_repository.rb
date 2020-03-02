class UserRepository

  class << self

    def find_by_email(email)
      User.find_by_email(email)
    end
  end
end