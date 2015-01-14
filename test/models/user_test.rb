require "test_helper"

class UserTest < ActiveSupport::TestCase

  def user
    @user ||= create_user
  end

  def test_valid
    assert user.valid?
  end

end
