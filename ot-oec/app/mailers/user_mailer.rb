class UserMailer < ActionMailer::Base
	default from: 'noreply@onetaste.us'

	def welcome_email(user, program, host)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
		body = JSON.parse(program.welcome_email)['markdown']
		body.gsub! "{confirm_link}", "%s/users/confirm/%s" % [host, user.confirmation_token]

    sub = program.welcome_email_subject
		mail(to: user.email, subject: sub ) do |format|
			format.html { markdown.render(body) }
		end 
	end

	def safeword_red_email(user, user_program, host)
		@user = user
		@user_program = user_program
		mail :to => @user_program.pod.leader.email, :subject => "Student RED: %s" % user.name
	end

	def created_new_challenge(user, challenge)
		@user = user
		@challenge = challenge
		@link = challenge_url(@challenge)
		mail :to => @user.email, :subject => "Created new challenge"
	end

	def created_new_event(user, event)
		@user = user
		@event = event
		@link = calendar_url
		mail :to => @user.email, :subject => "New Event Announced"
	end

	def created_new_announcement(user, announcement)
    @announcement = announcement
		mail to: user.email, subject: "[#{announcement.program.name}] #{announcement.subject}"
	end

	def created_new_blog(user,blog)
		@user = user
		@blog = blog
		@link = post_url(blog)
		mail :to => @user.email, :subject => "Created new Blog"
	end

	def commented_on_your_post(post, comment)
		@comment_user = comment.by
		@comment = comment
		@user = post.by
		@post = post
		@link = post_url(post)
		mail :to => @user.email, :subject => "#{comment.program.name} - New comment on your post"
	end

  # NOT USED
	def commented_on_your_comment(user, post, comment)
		@user = user
		@post = post
		@comment = comment
		@link = post_url(post)
		mail :to => @user.email, :subject => "Commented on your comment"
	end 
  # ---

  # NOT USED
	def commented_on_your_challenge(challenge, comment)
		@comment_user = comment.by
		@comment = comment
		@user = challenge.created_by
		@challenge = challenge
		@link = '/'
		mail :to => @user.email, :subject => "Commented on your challenge"
	end
  # ---
	
	def commented_on_your_experience(experience, comment)
		@comment_user = comment.by
		@comment = comment
		@user = experience.created_by
		@experience = experience
		mail :to => @user.email, :subject => "#{comment.program.name} - New comment on your experience"
	end

	def commented_on_your_profile(user, comment)
		@comment_user = comment.by
		@comment = comment
		@user = user
		@link = user_url(user)
		mail :to => @user.email, :subject => "#{comment.program.name} - New comment on your profile"
	end

	def note_to_following_experience(user, exp, comment)
		@comment = comment
		@user = user
		@link = experience_url(exp)
		mail :to => @user.email, :subject => "#{comment.program.name} - Note on an experience you're following"
	end

	def note_to_your_experience
	end

end
