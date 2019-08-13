class ContactUsMailer < ApplicationMailer
  def notification_user(contact, domain)
    @contact = contact
    @domain = domain
    mail(from: 'Kanahome', :to => contact.email, :subject => contact.subject)
  end

  def notification_dev(contact, domain)
    @contact = contact
    @domain = domain
    mail(from: 'Kanahome', :to => "martin.me15@yahoo.com", :subject => "[Admin] #{contact.subject}")
  end

  def notification_admin(contact, domain)
    @contact = contact
    @domain = domain
    mail(from: 'Kanahome', :to => "kanahome.ols@gmail.com", :subject => "[Admin] #{contact.subject}")
  end
end
