class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable

  has_many :sent_messages, foreign_key: :sender_id, class_name: "Message", dependent: :destroy
  has_many :read_user_messages, -> { where read: true }, class_name: "UserMessage", dependent: :destroy
  has_many :unread_user_messages, -> { where read: false }, class_name: "UserMessage", dependent: :destroy
  has_many :read_messages, through: :read_user_messages, source: :message, dependent: :destroy
  has_many :unread_messages, through: :unread_user_messages, source: :message, dependent: :destroy
  has_many :favorite_messages, dependent: :destroy
  has_many :starred_messages, through: :favorite_messages, source: :message, dependent: :destroy

  enum active_session: [ :offline, :online ]

  def is_favorite? message
    self.starred_messages.include? message
  end

end
