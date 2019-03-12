class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, -> { order(created_at: :asc) }, dependent: :destroy
  acts_as_list scope: :project

  validates :title, presence: true

  def as_json(options = {})
    super(options.merge(include: :comments))
  end
end
