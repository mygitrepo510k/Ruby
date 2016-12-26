class ConversationsController < ApplicationController
	before_filter :require_login!	
	helper_method :mailbox, :conversation

	def create
		session[:return_to] ||= request.referer
		recipient_emails = conversation_params(:recipients).split(',')
		recipients = User.where(email: recipient_emails).all
		asdf
		conversation = current_user.send_message(recipients, *conversation_params(:body, :subject)).conversation
		flash[:notice] = "Message Sent"
		redirect_to session[:return_to]
	end

	def reply
		current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
		redirect_to conversation
	end

	def trash
		conversation.move_to_trash(current_user)
		redirect_to :messagebox_inbox
	end

	def untrash
		conversation.untrash(current_user)
		redirect_to :messagebox_inbox
	end

	def show
		conversation.receipts.each do |rm|
			rm.message.mark_as_read(current_user);
		end
		session["unread_message_count"] = current_user.mailbox.inbox(:read => false, :trash => false).count(:id, :distinct => true) if current_user.present?
#		render :text => m.inspect and return
		#current_user.mailbox.conversations.find(params[:id]).receipts.each do |receipt|
		#	receipt.mark_as_read("true")
		#end
	end	
	private

	def mailbox				
		@mailbox ||= current_user.mailbox
	end

	def conversation
		@conversation ||= mailbox.conversations.find(params[:id])
	end

	def conversation_params(*keys)
		fetch_params(:conversation, *keys)
	end

	def message_params(*keys)
		fetch_params(:message, *keys)
	end

	def fetch_params(key, *subkeys)
		params[key].instance_eval do
			case subkeys.size
			when 0 then self
			when 1 then self[subkeys.first]
			else subkeys.map{|k| self[k] }
			end
		end
	end
end