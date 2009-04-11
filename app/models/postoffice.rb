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
end
