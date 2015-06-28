require 'mail'

class StaticPagesController < ApplicationController
	protect_from_forgery with: :null_session

	def contact
		@user = current_user
    end

    def email
    	@user_name = params[:name]
    	@user_email = params[:email]
    	@user_message = params[:message]
    	mail = Mail.new do
 		 from    'yunyingtu@gmail.com'
 		 to      'yinyic@usc.edu'
 		 subject 'This is a test email'
		 body    'test'
		end
		mail.to_s

    end
end


