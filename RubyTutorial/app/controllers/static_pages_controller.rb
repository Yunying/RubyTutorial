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
    end
end


