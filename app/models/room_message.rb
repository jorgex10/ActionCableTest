class RoomMessage < ApplicationRecord

  belongs_to :room
  belongs_to :user

  validates :body, presence: true

  after_create_commit { RoomMessageBroadcastJob.perform_later self }

end
