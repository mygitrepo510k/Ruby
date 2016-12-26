class Admin::DashboardController < AdminController
  def index
    @photos = UserPhoto.unapproved
    @abuse_messages = Message.abuse
  end
end
