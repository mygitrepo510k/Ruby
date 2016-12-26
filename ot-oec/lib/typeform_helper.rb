require 'net/http'
# require 'typeform_helper'
# prog = Program.first
# TypeFormHelper.import_intake_forms(Program.first)
# JSON.parse(TypeForm.last.response)

module TypeFormHelper
	def self.import_intake_forms(prog, form_id)
    cp8 = 'iJF5rV'
		url = 'https://api.typeform.com/v0/form/%s?key=ec44298991aecce611682827a7c9b91a5a301c49&completed=true' % cp8
		json = TypeFormHelper.getjson(url)
		TypeFormHelper.applydata(json, prog, 'intake')
	end

	def self.intake_answers(prog, user, empty)
		# user = User.find(2); prog = Program.first
		form = TypeForm.joins(:program).joins(:user).where(program: prog, user: user, form: 'intake').last
		if (form and form.response) or empty
			answers = (form and form.response) ? JSON.parse(form.response)['answers'] : {}
			questions = TypeFormHelper.intake_questions()
			questions.map {|x| {id: x['id'], question: x['question'], answer: answers[x['id']], fieldinfo: x[:fieldinfo]}}
		end
	end

	def self.intake_questions()
		fieldinfo = JSON.parse(File.open("lib/typeform_intake_fieldinfo.json", "r").read())
		questions = JSON.parse(File.open("lib/typeform_intake.json", "r").read())['questions']
		questions.select {|x| not fieldinfo['exclude'].index(x['id'])}.map do |q|
			info = fieldinfo['fields'].select {|x| x['id'] == q['id']}.first
			if info; q.merge(fieldinfo: info['data']); else; q; end
		end
	end

	def self.applydata(json, prog, formname)
		# update all the responsed for this form
		for r in json['responses']
			form = TypeForm.joins(:program).joins(:user).where(program: prog, response_id: r['id'], form: formname).last
			data = JSON.generate(r)
			if form
				if not form.response or (form.response and not form.response['user_edited'])
					form.update!(response: data)
				end
			else
				TypeForm.create!(program: prog, form: 'intake', response_id: r['id'], response: data)
			end
		end
	end

	def self.getjson(url)
		uri = URI(url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Get.new(uri.request_uri)
		body = http.request(request).body
		json = JSON.parse(body)
		json
	end
end
