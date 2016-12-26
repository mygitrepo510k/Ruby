class AdminController < ApplicationController
  autocomplete :user, :name, full: true
	before_filter :require_leader

	def thegrid
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
	end

	def index
	end
end
