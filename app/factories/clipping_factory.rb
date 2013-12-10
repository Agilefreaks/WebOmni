class ClippingFactory
  def create(channel, content)
    User.find_by(email: channel).clippings.create(content: content, type: get_type(content))
  end

  private

  def get_type(content)
    Phoner::Phone.valid?(content.clone) ? Clipping::TYPES[:phone_number] : Clipping::TYPES[:unknown]
  end
end