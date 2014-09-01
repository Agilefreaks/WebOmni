class ContactMailer < BaseMailer
  default template_path: "mailers/#{self.name.underscore}"

  def email(contact)
    @message = contact.message

    mail({
             subject: "#{contact.name} with #{contact.email} has something to tell you",
             from: 'Calin <calin@omnipasteapp.com>',
             to: 'team@omnipasteapp.com'
         })

  end
end
