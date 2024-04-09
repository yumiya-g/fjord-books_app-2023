# frozen_string_literal: true

require 'test_helper'
require 'users_helper'

class ActiveSupport::TestCase
  include UsersHelper
end

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = create(:user)
    assert user.name_or_email
    user.name = 'Alice'
    assert_equal 'Alice', user.name_or_email
  end

  test '#current_user_name' do
    user = create(:user)
    assert current_user_name(user)
    user.name = 'Alice'
    assert_equal 'Alice', current_user_name(user)
  end
end
