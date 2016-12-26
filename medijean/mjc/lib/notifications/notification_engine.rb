# Provides methods to create and manage notifications
class NotificationEngine
  # Sends a notification to the user
  # @param [User] user the user to send the notification to
  # @param [Symbol] type the type of the notification
  # @param [Hash] parameters the parameters of the notification
  def notify(user, type, parameters)
    notification = Notification.create!(:user => user, :type => type, :parameters => parameters)
  end
end