require 'typeform_helper'

class TypeFormsController < ApplicationController
	before_filter :allowed_users, only: [:intake, :update_intake]

	def intake
		@fields = TypeFormHelper.intake_answers(@user.current_program, @user, true)
	end

	def update_intake
		# create the list of answers from the fields on the form
		pieces = params.keys.select{|x| x['field_']}.map{|x| x[6..-1]}.map {|x| {x => params["field_#{x}"]}}
		answers = {}
		pieces.each {|x| answers.merge!(x)}

		# stuff into a string json object for storage
		json = JSON.generate({answers: answers, user_edited: DateTime.now})

		# look up the users' last response, or create a new one
		prog = @user.current_program
		form = TypeForm.where(program: prog, user: @user, form: 'intake').last
		if form
			form.update!(response: json)
		else
			TypeForm.create!(program: prog, user: @user, form: 'intake', response: json)
		end

		# go back to the user's record
		redirect_to @user
	end

	def allowed_users
		@user = User.find(params[:user_id])
		if @user != current_user and !current_user.admin?; redirect_to(@user, alert: "you can only edit your own intake form") and return; end
	end
end