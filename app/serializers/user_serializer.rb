class UserSerializer < ApplicationSerializer

  attributes :name, :email, :authentication_token
end