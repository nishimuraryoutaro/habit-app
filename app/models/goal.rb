class Goal < ApplicationRecord
  belongs_to :user
  has_many :daily_tasks, dependent: :destroy
end
