require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome_email" do
    user = users(:one)
    mail = UserMailer.welcome_email(user)
    assert_equal "Welcome to My Awesome App", mail.subject
    assert_equal [ user.email ], mail.to
    assert_equal [ "notifications@example.com" ], mail.from
    assert_match "Welcome to example.com", mail.body.encoded
  end
end
