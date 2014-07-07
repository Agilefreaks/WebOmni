module ContactsHelper
  def contact(model)
    model || Contact.new
  end
end