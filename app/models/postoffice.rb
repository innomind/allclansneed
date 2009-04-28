class Postoffice < ActionMailer::Base

  # example message
  def example(subject, message="")
    recipients "pwesner@innomind.info"
    from  "support@allclansneed.de"
    subject subject
    body :body => message
  end
  
  def email_activation user
    recipients user.email
    from  "support@allclansneed.de"
    subject "Email Aktivierung"
    body :user => user
  end
  
  def new_message(sender, receiver)
    recipients receiver.email
    from  "support@allclansneed.de"
    subject "Neue Nachricht"
    body :sender => sender, :receiver => receiver
  end
  
  def become_friend(become, become_with)
    recipients become_with.email
    from  "support@allclansneed.de"
    subject "Neue Freundschaftseinladung"
    body :become => become, :become_with => become_with
  end
  
  def reset_password(user)
    recipients user.email
    from  "support@allclansneed.de"
    subject "Neues Passwort"
    body :new_pw_user => user
  end
  
  def welcome_site(site)
    return "" if site.nil?
    return "" if site.owner.nil?
    recipients site.owner.email
    from "support@allclansneed.de"
    subject "Willkommen bei Allclansneed"
    body :site => site
  end
  
end
