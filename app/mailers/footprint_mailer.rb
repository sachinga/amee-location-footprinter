class FootprintMailer < ActionMailer::Base
  default :from => "from@example.com"

  def footprint_email(user, checkins=nil)
    @user = user
    @checkins = checkins
    @total_co2 = 0
    @url  = "http://example.com/login"
    
    
    # if @user.last_email_sent < Date.current.ago(7)
      send_email_and_update_last_sent(@user)
    # end
    # check the time and only send the last email was sent more than a week ago

  end

end

def send_email_and_update_last_sent(user)
  user.last_email_sent = DateTime.now
  mail(:to => user.email, :subject => "Check out your Checkins")
end