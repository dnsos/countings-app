require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "new user receives user role per default" do
    user = User.new
    user.valid?
    assert_equal user.role, "user"
  end
end
