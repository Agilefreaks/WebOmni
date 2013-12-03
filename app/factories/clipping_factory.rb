class ClippingFactory
  def self.create(params)
    clipping = Clipping.create(content: params[:content],
                               token: params[:token],
                               type: get_type(params[:content]))

    Notify.user(params[:token], params[:registrationId])

    clipping
  end

  def self.get_type(content)
    Phoner::Phone.valid?(content.clone) ? Clipping::TYPES[:phone_number] : Clipping::TYPES[:unknown]
  end
end