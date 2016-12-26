class MessageboxController < ApplicationController

  before_filter :require_login!
  helper_method :mailbox, :conversation, :unread?
  
  def inbox    
    if params[:subject].present?
      #@mail_box = current_user.mailbox.inbox.paginate(:page => params[:page_num], :per_page => 9, :conditions => ["conversations.subject LIKE ?", "%"+params[:subject]+"%"] )
      mailbox = Array.new
      mails = current_user.mailbox.inbox
      mails.each do |mail|
        mailbox << mail if mail.messages.find(:all, :conditions=>['LOWER(body) like ?', "%#{params[:subject]}%"]).present?        
      end

      @mail_box = mailbox

    else
      @mail_box = current_user.mailbox.inbox.paginate(:page => params[:page_num], :per_page => 9 )
    end
  end

  def sent
    if params[:subject].present?
      #@mail_box = current_user.mailbox.sentbox.paginate(:page => params[:page_num], :per_page => 9, :conditions => ["conversations.subject LIKE ?", "%"+params[:subject]+"%"] )
      mailbox = Array.new
      mails = current_user.mailbox.sentbox
      mails.each do |mail|
        mailbox << mail if mail.messages.find(:all, :conditions=>['LOWER(body) like ?', "%#{params[:subject]}%"]).present?        
      end

      @mail_box = mailbox

    else
      @mail_box = current_user.mailbox.sentbox.paginate(:page => params[:page_num], :per_page => 9 )
    end
  end

  def deleted
    if params[:subject].present?
#      @mail_box = current_user.mailbox.trash.paginate(:page => params[:page_num], :per_page => 9, :conditions => ["conversations.subject LIKE ?", "%"+params[:subject]+"%"] )
      mailbox = Array.new
      mails = current_user.mailbox.trash
      mails.each do |mail|
        mailbox << mail if mail.messages.find(:all, :conditions=>['LOWER(body) like ?', "%#{params[:subject]}%"]).present?        
      end
      @mail_box = mailbox

    else
      @mail_box = current_user.mailbox.trash.paginate(:page => params[:page_num], :per_page => 9)
    end    
  end


  def unread? inbox_mail
    inbox_mail.receipts.inbox.each do |rm|
      return true if rm.is_unread? and rm.message.sender != current_user
    end
    return false
  end 
  private

  def search_mail message_type, search_body, page_num
    mailbox = Array.new
    mails = nil
    if message_type = "inbox"
      mails = current_user.mailbox.inbox
    elsif message_type = "sentbox"
      mails = current_user.mailbox.sentbox      
    else
      mails = current_user.mailbox.trash
    end
    mails.each do |mail|
      mailbox << mail if mail.messages.find(:all, :conditions=>['body like ?', "%#{search_body}%"]).present?        
    end
    return mailbox
  end
end


#<Receipt id: 75, receiver_id: 2, receiver_type: "User", notification_id: 45, is_read: true, trashed: false, deleted: false, mailbox_type: "inbox", created_at: "2013-03-24 13:45:04", updated_at: "2013-03-24 13:45:04">, 
#<Receipt id: 76, receiver_id: 1, receiver_type: "User", notification_id: 45, is_read: true, trashed: false, deleted: false, mailbox_type: "sentbox", created_at: "2013-03-24 13:45:04", updated_at: "2013-03-24 13:45:04">, 
#<Receipt id: 79, receiver_id: 1, receiver_type: "User", notification_id: 47, is_read: false, trashed: false, deleted: false, mailbox_type: "inbox", created_at: "2013-03-24 14:38:08", updated_at: "2013-03-24 14:38:08">, 
#<Receipt id: 80, receiver_id: 2, receiver_type: "User", notification_id: 47, is_read: true, trashed: false, deleted: false, mailbox_type: "sentbox", created_at: "2013-03-24 14:38:08", updated_at: "2013-03-24 14:38:08">