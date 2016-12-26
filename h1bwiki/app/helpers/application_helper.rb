module ApplicationHelper
	#Replace form_for
	#include MNE::TwitterBootstrapFormBuilder::Helper
	def isEmployer
		employer?
	end

	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink=> true, :space_after_headers => true)
		markdown.render(text).html_safe
	end

	def syntax_highlighter(html)
		doc = Nokogiri::HTML(html)
		doc.search("//pre[@lang]").each do |pre|
			pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
		end
		doc.to_s
	end
end
