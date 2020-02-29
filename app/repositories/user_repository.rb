class UserRepository

  class << self

    def all
      User.all
    end

    def find_by_id(id)
      User.find(id)
    end

  end
end