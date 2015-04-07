class ContactsController < ApplicationController
  respond_to :js

  def create
    contact = Contact.new(contact_params)
    ContactMailer.email(contact).deliver

    head :ok
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
