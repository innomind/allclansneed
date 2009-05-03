module MessageHelper
  def message_pic message
    return image_tag("email.png") unless message.read
    return image_tag("email_go.png") if message.answered
    image_tag("email_open.png")
  end
end