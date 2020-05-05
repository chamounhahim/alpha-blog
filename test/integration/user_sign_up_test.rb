require 'test_helper'

class UserSignUpTest < ActionDispatch::IntegrationTest

    test "get sign up form and create new user" do
        get signup_path
        assert_template 'users/new'
        assert_difference 'User.count', 1 do
            post users_path, params: {user: {username: "joe", email: "joe@example.com", password: "password"}}
            follow_redirect!
        end
        get users_path
        assert_template 'users/index'
        assert_match "joe", response.body
    end

end