class ContactsController < ApplicationController
  def create
    Contact.create(contact_params)
    redirect_to root_url, notice: 'Got it, will let you know as soon as possible.'
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end