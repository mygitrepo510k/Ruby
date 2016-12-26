# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'
require 'ipsum'
require 'typeform_helper'

def seedme
	# to speed up load times, use this command:
	# rake db:reset minimal=true dummy=true
	# for noah: minimal=true dummy=true rdbr
	minimal = (ENV['minimal'] == 'true')
	dummy = (ENV['dummy'] == 'true')
	puts "  using dataset: %s" % (minimal ? "minimal (no remote calls)" : "full set (imgs+omhub)")

	# clear existing data
	# [Program.all, User.all, Pod.all, UserProgram.all].each {|x| x.each {|y| y.delete}}

	# create the CP8 program
	mails = { markdown: File.open("db/seed/cp8_welcome_email.md", "r").read(), text: File.open("db/seed/cp8_welcome_email.txt", "r").read() }
	prog = Program.create({name: 'CP8', welcome_email: JSON.generate(mails), root_content_node: ContentNode.create!(name: 'cp8 root')})
	if dummy; nicole = Program.create({name: 'Nicole Intensive', welcome_email: ''}); end
	# prog = Program.first

	# add users
	puts "  adding users"
	users = [
		['Noah Coad', 'noah@coad.net', 'orgasm123', 'admin', 'yellow'], 
		['Hamza Tayeb', 'hamza.tayeb@gmail.com', 'orgasm123', 'student', 'red'], 
		['Marcus Ratnathicam', 'marcus@onetaste.us', 'orgasm123', 'admin', 'green'],
		['Rachel Cherwitz', 'rachel.cherwitz@onetaste.us', 'orgasm123', 'pod_leader', 'yellow'],
		['Leah Mendelson', 'leah.mendelson@onetaste.us', 'orgasm123', 'student', 'green']]
	users.each {|u| if not User.find_by(email: u[1]); User.create!(name: u[0], email: u[1], 
		password: u[2], password_confirmation: u[2], confirmed_at: DateTime.now, super_admin: true, 
		current_program: prog, skip_omhub_pull: minimal); end }

	# some specific handy users
	marcus = User.find_by(email: 'marcus@onetaste.us')
	hamza = User.find_by(email: 'hamza.tayeb@gmail.com')
	noah = User.find_by(email: 'noah@coad.net')
	leah = User.find_by(email: 'leah.mendelson@onetaste.us')
	rachel = User.find_by(email: 'rachel.cherwitz@onetaste.us')

	# create a pod
	pod = dummy ? Pod.create!(name: 'OGeeks', leader: marcus, program: prog) : nil

	# add users to program (and pod)
	for u in users
		UserProgram.create!(role: u[3], pod: pod ? (pod.leader.email != u[1] ? pod : nil) : nil, 
			user: User.find_by(email: u[1]), program: prog, safeword: u[4])
	end

	# also enroll in another program
	if dummy; [noah, hamza].each {|x| UserProgram.create!(program: nicole, user: x, safeword: 'red')}; end

	# add challenges
	if dummy
		puts "  adding challenges"
		challenges = [
			{ challenge: { name: 'Run a TurnOn Event', description: 10.sentences, created_by: marcus, program: prog, due: (DateTime.now + 1)}, 
				cover: 'db/seed/turnon.jpg', urls: [
					{ name: 'post on meetup', url: 'http://www.meetup.com/OneTaste-Austin/events/173395552/' }, 
					{ name: 'promo image', url: 'http://4.bp.blogspot.com/-Ot6AVqnz8qE/TW5xwpHFPlI/AAAAAAAADx8/q4NiGlTuZbQ/s1600/omweb.jpg' },
					{ name: 'see the staff', url: 'http://1.bp.blogspot.com/-THhhakFdfPo/Tvp4I0ivLrI/AAAAAAAAA0c/v6kmssZ5xIc/s1600/One+Taste+7th+Birthday-6.jpg' }],
				comments: [
					{ body: 'get lots of chairs', by: hamza },
					{ body: 'a great location is important too', by: marcus },
					{ body: 3.sentences, by: marcus },
					{ body: 'mmmm, get it', by: noah }],
				frames: [
					{ frame: { user: hamza, note: "I got this shiz!", created_at: DateTime.now - 2 }, urls: [ 
						{ name: 'held mine here', url: 'http://www.churchofgod.org/' } ],
						comments: [ { body: 10.sentences, by: noah }, { body: 3.sentences, by: marcus } ] },
					{ frame: { user: noah, note: "I got this shiz!", created_at: DateTime.now - 10 }, urls: [ 
						{ name: 'held mine here', url: 'http://www.churchofgod.org/' } ],
						comments: [ { body: 10.sentences, by: noah }, { body: 3.sentences, by: marcus } ] } 
					] },
			{ challenge: { name: 'Get 5 Coaching Clients', description: 6.sentences, created_by: hamza, program: prog, due: DateTime.now - 1}, 
				cover: 'db/seed/coaching.jpg', 
				urls: [ { name: 'how to', url: 'http://www.redtube.com/308360' } ],
				comments: [ { body: 'dude, get 20!', by: marcus } ],
				frames: [] },

			{ challenge: { name: 'Make $10k Coaching', description: 6.sentences, created_by: leah, program: prog, due: DateTime.now - 20, special: true}, 
				cover: 'db/seed/Money-100s.jpg', 
				urls: [ { name: 'how to', url: 'https://www.youtube.com/watch?v=ek0gtSqWSWQ' } ],
				users: [ hamza, noah, marcus ], pods: [ pod ],
				comments: [ { body: 'dude, get 20!', by: marcus } ],
				frames: [] },
			{ challenge: { name: 'Make Candles', description: 6.sentences, created_by: leah, program: prog, due: DateTime.now - 20, special: true}, 
				cover: 'db/seed/wave-hill-honey_weekend_candle_making-credit-joshua-bright.jpg__524x349_q85_crop_upscale.jpg', 
				urls: [ { name: 'how to', url: 'https://www.youtube.com/watch?v=GkSa7RlAKJE' } ],
				users: [ leah, marcus ], pods: [ ],
				comments: [ { body: 'dip the candle good', by: marcus } ],
				frames: [] },
			{ challenge: { name: 'Get a New Job', description: 6.sentences, created_by: leah, program: prog, due: DateTime.now - 10, special: true}, 
				cover: 'db/seed/Job-Search-Competition.jpg', 
				urls: [ { name: 'how to', url: 'http://onetaste.us/jobs/' } ],
				users: [ ], pods: [ pod ],
				comments: [ { body: 'dude, get 20!', by: marcus } ],
				frames: [
					{ frame: { user: leah, note: "I got this shiz!", created_at: DateTime.now - 10 }, urls: [ 
						{ name: 'held mine here', url: 'http://www.churchofgod.org/' } ],
						comments: [ { body: 6.sentences, by: hamza }, { body: 3.sentences, by: noah } ] } 
					] }
			]
		for c in challenges
			cg = ContentGroup.create!(created_by: c[:challenge][:created_by])
			ch = Challenge.createone(c[:challenge], minimal ? nil : open(c[:cover]))
			addurls(c[:urls], cg)
			c[:urls].each {|x| ContentGroupItem.create!(content_group: cg, content: Content.create!(x)) }
			c[:comments].each {|x| ch.comments << Comment.create!(x) }
			if c[:challenge][:special]
				c[:users].each {|x| ch.user_programs << x.user_programs.find_by(program: prog)}
				c[:pods].each {|x| ch.pods << x}
			end
			for f in c[:frames]
				cg = ContentGroup.create!(created_by: f[:user])
				cf = ChallengeFrame.create!(f[:frame].merge({challenge: ch, content_group: cg}))
				addurls(f[:urls], cg)
				f[:comments].each {|x| cf.comments << Comment.create!(x) }
			end
		end

		cg = ContentGroup.find(1)
		pics = [
			{ name: 'YODA', created_by_id: noah,
				description: 'Try not, there is no try, do or do not', image: open('app/assets/images/yoda.png'), content_type: :image },
			{ name: 'BEAST', created_by_id: hamza,
				description: 'BEAST!!!!', image: open('app/assets/images/beast.jpg'), content_type: :image }
		]

		if !minimal
			pics.each {|pic| cg.contents << Content.create(pic) }
		end

		# ContentGroupItem.create!(content_group: cg, content: Content.create!(name: 'how to', url: 'http://www.redtube.com/308360'))
		# ContentGroupItem.create!(content_group: cg, content: Content.create!(name: 'how to, take 2', url: 'http://www.redtube.com/44972'))

		# add posts and comments
		puts "  adding posts"
		posts = [ 
			{ body: 'What is something new you\'re learning about life?', by: marcus, comments: [
				{ body: 'Dana', by: hamza, scope: nil },
				{ body: 1.sentences, by: marcus, scope: nil },
				{ body: 'Leah M', by: noah, scope: nil }] },
			{ body: 'what is a rimshot?', by: hamza, comments: [
				{ body: 'a basketball shot', by: marcus },
				{ body: 'a sexy manuver', by: noah }] } ]
		for post in posts
			p = Post.create!(post.slice(:body, :by).merge(program: prog))
			# post[:comments].each {|x| p.comments << Comment.create!(x.merge(commentable_type: 'Post'))}
		end

		# add experiences
		puts "  adding experiences"
		expframe = ContentGroupItem.create!(content_group: ContentGroup.create!(), content: Content.create!(name: 'some video link tbd')).content_group
		experiences = [ 
			{ exp: { name: 'Facing Rejection', created_by: marcus, created_for: noah, description: 2.sentences, executed_at: DateTime.now, executed_by: marcus },
				followers: [ leah, hamza ], frame: { urls: [ { name: 'how to', url: 'https://www.youtube.com/watch?v=ek0gtSqWSWQ' } ]} },
			{ exp: { name: 'Sharing a Secret', created_by: noah, created_for: noah, description: 4.sentences },
				followers: [ marcus ] },
			{ exp: { name: 'You Got No Money', created_by: leah, created_for: marcus, description: 6.sentences, frame: expframe },
				followers: [ rachel ] },
			{ exp: { name: 'Makeout w Two Women at the Same Time', created_by: hamza, created_for: marcus, description: 6.sentences },
				followers: [ noah ] },
			{ exp: { name: 'Car Race', created_by: leah, created_for: hamza, description: 6.sentences, executed_at: DateTime.now, executed_by: leah },
				followers: [ rachel ] },
			{ exp: { name: 'Kidnapped', created_by: leah, created_for: marcus, description: 6.sentences },
				followers: [ marcus, noah, hamza ] },
			{ exp: { name: 'Beach Party', created_by: noah, created_for: hamza, description: 6.sentences },
				followers: [ marcus, leah ] },
			{ exp: { name: 'Unwelcomed Guest', created_by: leah, created_for: hamza, description: 8.sentences },
				followers: [ marcus ] },
			{ exp: { name: 'Swingers Party', created_by: marcus, created_for: noah, description: 2.sentences },
				followers: [  ] },
			{ exp: { name: 'Recieving a Footbath', created_by: marcus, created_for: leah, description: 2.sentences },
				followers: [  ] },
			]
		for e in experiences
			exp = Experience.create!(e[:exp].merge(program: prog))
			e[:followers].each {|x| ExperienceFollower.create!(experience: exp, user: x)}
			if e[:frame]
				cg = ContentGroup.create!()
				addurls(e[:frame][:urls], cg)
				exp.update!(frame: cg)
			end
		end
	end

	# intake forms
	# TypeForm.find_by(user: hamza)
	# hamza = User.find_by(email: 'hamza.tayeb@gmail.com')
	# TypeForm.where(response_id: 340).count
	txt = File.open("db/seed/intake.json", "r").read()
	json = JSON.parse(txt)
	intakes = [[hamza, 340]]
	intakes.each {|x| TypeForm.create!(response_id: x[1], user_program: UserProgram.find_by(user: x[0], program: prog), program: prog, user: x[0], form: 'intake')}
	TypeFormHelper.applydata(json, prog, 'intake')
end

def addurls(urls, cg)
	urls.each {|x| ContentGroupItem.create!(content_group: cg, content: Content.create!(x)) }
end

# run the seed generator
seedme


# live data updates
# Program.first.update!(root_content_node: ContentNode.create!(name: 'cp8 root'))
