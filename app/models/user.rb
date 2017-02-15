class User < ApplicationRecord

  include Avatarable

  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable

  has_many :sent_messages, foreign_key: :sender_id, class_name: "Message", dependent: :destroy
  has_many :read_user_messages, -> { where read: true }, class_name: "UserMessage", dependent: :destroy
  has_many :unread_user_messages, -> { where read: false }, class_name: "UserMessage", dependent: :destroy
  has_many :read_messages, through: :read_user_messages, source: :message, dependent: :destroy
  has_many :unread_messages, through: :unread_user_messages, source: :message, dependent: :destroy
  has_many :favorite_messages, dependent: :destroy
  has_many :starred_messages, through: :favorite_messages, source: :message, dependent: :destroy
  has_many :room_messages
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms

  enum active_session: [:offline, :online]

  has_attached_file :photo, styles: { thumb: '150x150#' }

  validates :first_name, :last_name, presence: true
  validates_attachment :photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  before_validation { photo.clear if remove_photo == '1' }

  attr_accessor :remove_photo

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_text
    email.chr
  end

  def is_favorite? message
    self.starred_messages.include? message
  end

  def has_unread_messages? room
    sender = (room.users.includes(:user_rooms) - [self]).first
    room.room_messages.where(user: sender, read: false).count == 0 ? false : true
  end

  def self.search_with query
    if query.present?
      where("first_name || last_name || email ILIKE ?", "%#{query}%")
    else
      all
    end
  end

end
