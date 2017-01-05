class Message < ApplicationRecord

  validates :sender_id, :body, presence: true

  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  has_many :user_messages
  has_many :receivers, through: :user_messages, source: :user

  def is_receiver? user
    self.receivers.include? user
  end

  def is_sender? user
    self.sender == user
  end

  def can_show? user
    self.is_sender?(user) or self.is_receiver?(user)
  end

  def read! user
    user_message = UserMessage.find_by(user: user, message: self)
    user_message.update(read: true) unless user_message.read
  end

end
