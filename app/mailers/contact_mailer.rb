class ContactMailer < BaseMailer
  def email(contact)
    @message = contact.message

    mail({
             subject: "#{contact.name} has something to tell you",
             from: "#{contact.name} <#{contact.email}>",
             to: 'team@omnipasteapp.com'
         })

  end
end