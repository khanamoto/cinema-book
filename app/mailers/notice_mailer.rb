class NoticeMailer < ApplicationMailer
  default from: ENV['EMAIL_USER']

  def sendmail_contact(user)
    @user = user
    mail to: user.contact_email,
      subject: '【Films】お問い合わせありがとうございます'
  end

  def sendmail_contact_me(user)
    @user = user
    mail to: ENV['EMAIL_MYSELF'],
      subject: '【Films】お問い合わせがありました'
  end
end
