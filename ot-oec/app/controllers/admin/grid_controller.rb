class Admin::GridController < ApplicationController
	before_filter :require_leader
  respond_to :json, except: [:thegrid]

	def thegrid
  end

  def challenges
		u = current_user
		if params.has_key?(:specials)
			@challenges = u.current_program.challenges.order(created_at: :desc).where(special: true)

			# todo: move this to a query that pulls all the users for this program that have special programs
			@users = []
			for c in @challenges
				@users.concat c.user_programs.map {|x| x.user}
				@users.concat c.pods.map {|x| x.users}
			end
		else
			# todo: update user query so that we get the user's safeword for this program in the query
			@users = User.includes([:challenge_frames, :challenges]).joins(:user_programs).where(user_programs: { program: u.current_program, role: 0 })
			@challenges = u.current_program.challenges.order(created_at: :desc).where(special: false)
		end

    render json: { html: render_to_string(partial: 'challenges', layout: false) }
  end

  def experiences
    program = current_user.current_program
    @experiences = Experience.where(program: program)
    @students = program.students
    render json: { html: render_to_string(partial: 'experiences', layout: false) }
  end
end
