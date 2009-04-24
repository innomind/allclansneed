class Postoffice < ActionMailer::Base

  # example message
  def example(subject, message="")
    # Email header info MUST be added here
    recipients "pwesner@innomind.info"
    from  "noreply@allclansneed.com"
    subject subject

    # Email body substitutions go here
    body :body => message
  end
  
  def new_message(sender, receiver)
    recipients receiver.email
    from  "noreply@allclansneed.com"
    subject "Neue Nachricht"

    # Email body substitutions go here
    body :sender => sender, :receiver => receiver
  end
  
  def become_friend(become, become_with)
    recipients become_with.email
    from  "noreply@allclansneed.com"
    subject "Neue Freundschaftseinladung"

    # Email body substitutions go here
    body :become => become, :become_with => become_with
  end
  
  def reset_password(user)
    recipients user.email
    from  "noreply@allclansneed.com"
    subject "Neues Passwort"
    body :new_pw_user => user
  end
end
