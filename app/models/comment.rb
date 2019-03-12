class Comment < ApplicationRecord
  belongs_to :task
  mount_uploader :attachment, AttachmentUploader
  validates :title, presence: true
end
