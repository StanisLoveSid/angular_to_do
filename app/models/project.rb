class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  mount_uploader :attachment, AttachmentUploader

  def as_json(options = {})
    super(options.merge(include: { tasks: { include: :comments } }))
  end
end
