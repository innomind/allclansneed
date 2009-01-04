class Postoffice < ActionMailer::Base

  # example message
  def example( user )
    # Email header info MUST be added here
    recipients user.email
    from  "accounts@example.com"
    subject "Thank you for registering with our website"

    # Email body substitutions go here
    body :user=> user
  end

end
