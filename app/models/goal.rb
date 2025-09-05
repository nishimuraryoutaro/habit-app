class Goal < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :progress, inclusion: { in: 0..100 }
end
