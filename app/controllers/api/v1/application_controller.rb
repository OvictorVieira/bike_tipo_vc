class Api::V1::ApplicationController < ActionController::Base

  acts_as_token_authentication_handler_for User, except: [:login]

end