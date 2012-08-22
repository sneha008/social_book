require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "comment_made" do
    mail = Notifier.comment_made
    assert_equal "Comment made", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
