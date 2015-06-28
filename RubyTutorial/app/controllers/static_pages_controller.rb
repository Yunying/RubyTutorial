class StaticPagesController < ApplicationController

	protect_from_forgery with: :null_session

	def contact
		@user = current_user
    end

    def email
    	@name = params[:name]
    end
end
