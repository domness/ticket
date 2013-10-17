require 'spec_helper'

def sign_in(user)
  include Warden::Test::Helpers
  Warden.test_mode!
  login_as(user, :scope => "user")
  visit items_path
end
