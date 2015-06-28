class ContactMailer < ApplicationMailer
	default from: "yunyingtu@gmail.com"

	def contact_email
      mail(to: "yunyingtu@gmail.com", subject: 'Sample Email')
    end
end
