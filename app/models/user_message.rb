class UserMessage < ApplicationRecord

  validates :user_id, :message_id, presence: true

  belongs_to :user
  belongs_to :message

  after_create_commit { MessageBroadcastJob.perform_later self }

end
