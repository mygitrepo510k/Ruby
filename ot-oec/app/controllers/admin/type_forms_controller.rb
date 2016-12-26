require 'typeform_helper'

class Admin::TypeFormsController < ApplicationController
	before_filter :require_admin

	def associate
		prog = current_user.current_program
		forms = TypeForm.where(program: prog, form: 'intake').order('user_id DESC')
		@lookup = forms.map { |x| forminfo(x) }
		@users = User.joins(:user_programs).where(user_programs: { program: prog }).order(:name)
	end

	def reload_intakes
		prog = current_user.current_program
		TypeFormHelper.import_intake_forms(prog)
		redirect_to action: 'associate'
	end

	def update_associate
		ids = params.keys.select {|x| x['frame_id']}.map {|x| x[9..-1]}
		for id in ids
			uid = params["user_id_#{id}"]
			if uid
				tf = TypeForm.find(id).update!(user_id: uid)
			end
		end
		redirect_to action: 'associate'
	end

	def forminfo(x)
		json = x.response ? JSON.parse(x.response) : nill
		user = x.user		
		{ fid: x.id, fuid: user ? user.id : nil, fname: json ? json['answers']['textfield_531399'] : nil, oid: user ? user.id : nil, oname: user ? user.name : nil }
	end

  def missing_intakes
    @users = User.no_intake(current_user.current_program)
      .select {|u| u.user_programs.find_by(program: current_user.current_program).role == 'student' }
      .sort_by {|u| u.name }
  end
end
