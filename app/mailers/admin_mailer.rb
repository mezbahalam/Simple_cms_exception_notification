class AdminMailer < ActionMailer::Base
  default from: "mezbahalam27@gmail.com"

  def admin_created(admin_user)
    @admin_user = admin_user
    mail :subject => "a new admin created", :to => "mezbahalam26@gmail.com"
  end
end
