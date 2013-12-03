class UserMailer < ActionMailer::Base
  default :from => "laxmiror@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    attachments["navodayans.png"] = File.read("#{Rails.root}/public/images/navodayans.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end
