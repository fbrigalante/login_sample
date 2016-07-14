class RootController < ApplicationController
	def index
		if signed_out?
			redirect_to sign_in_path
		end
	end
end