class SkillsController < ApplicationController
	def index
		arg = params[:q];
		@skills = SkillList.where("lower(name) like lower(?)", "%#{arg}%")
		respond_to do |format|
			format.html
			format.json{ render :json => @skills.map(&:attributes)}
		end
	end

	def add_skill
		skill = SkillList.find_or_create_by_name(:name=>params[:skill])
		render :layout=>false, :text => skill.id, :status=>200		
	end
	
	def get_skill_id
		SkillList.last.id.to_i+1
	end
end