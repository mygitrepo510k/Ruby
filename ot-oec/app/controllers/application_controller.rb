class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	
	def require_login
		if !current_user; redirect_to new_user_session_path and return; end
		if !current_user.current_program
      sign_out
      redirect_to new_user_session_path, notice: 'You are not currently in any programs' and return
    end
	end

	def require_admin
		unless current_user and current_user.admin?
			flash[:error] = 'You are not authorized to view this page.'
			redirect_to root_path and return
		end 
	end

	def require_super_admin
		unless current_user and current_user.super_admin?
			flash[:error] = 'You are not authorized to view this page.'
			redirect_to root_path and return
		end 
	end

	def require_leader
		unless current_user and current_user.leader?
			flash[:error] = 'You are not authorized to view this page.'
			redirect_to root_path and return
		end 
	end

  def unauthorized location
    flash[:warn] = 'Unauthorized'
    redirect_to location
  end

	def common_layout_support
		@todo_challenges = Challenge.where(program: current_user.current_program)
		@todo_experiences = Experience.where(
      { created_for: current_user, frame: nil, program: current_user.current_program }).where.not({executed_at: nil})

		# ticker
		exp = Experience.joins(:frame).joins(:created_for)
      .where({program: current_user.current_program})
      .where.not({executed_at: nil, frame: nil, private: true }).select('experiences.*, users.name as uname')
      .order('content_groups.created_at DESC')

		exp = exp.to_a.map(&:serializable_hash)
      .map {|x| x.slice('id', 'user_id', 'uname', 'name', 'created_at').merge('activity' => 'Experience')}

		ch = ChallengeFrame.submitted.joins(:challenge).joins(:user)
      .where('challenges.program_id = ?', current_user.current_program.id)
      .select('challenge_frames.*, users.name as uname, challenges.name as name, challenge_frames.created_at as created_at')
      .order('challenge_frames.created_at DESC')

		ch = ch.to_a.map(&:serializable_hash)
      .map {|x| x.slice('id', 'user_id', 'uname', 'name', 'created_at')
      .merge('activity' => 'Challenge')}

		@ticker = (exp + ch).sort_by { |x| -x[:created_at].to_i }
    @announcements = Announcement.last_three current_user.current_program
	end

  def hash_to_ints(hash)
    Hash[ hash.map{ |k, v| [ k, begin; Integer v; rescue ArgumentError; v end ] } ]
  end
end
