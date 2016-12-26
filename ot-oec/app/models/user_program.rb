class UserProgram < ActiveRecord::Base
	attr_accessible :role, :user, :program, :role_id, :program_id, :pod, :safeword, :private_intake

	belongs_to :user
	belongs_to :program
	belongs_to :pod
	has_many :type_forms
	
	has_and_belongs_to_many :challenges

	enum role: [ :student, :pod_leader, :admin, :player, :staff ]
	enum safeword: [ :green, :yellow, :red ]
end
