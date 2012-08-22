class Notifier < ActionMailer::Base
  default from: "Sam Ruby <socialbook@example.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.comment_made.subject
  #
  def comment_made(post)
    @post = post

    mail :to => post.user.email, :subject => "#{post.user.firstname} commented on #{post.post_status}"
  end

  def post_updated(post,friend)
    @post = post
    @friend = friend

    mail :to => friend.map(&:email).join(","), :subject => "#{post.user.firstname} updated a post #{post.post_status}"
  end

end
