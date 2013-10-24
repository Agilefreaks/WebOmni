class ClippingFactory
  def self.create(params)
    Clipping.create(params.merge(content_type: get_type(params[:content])))
  end

  def self.get_type(content)
    Phoner::Phone.valid?(content.clone) ? Clipping::TYPES[:phone_number] : Clipping::TYPES[:unknown]
  end
end