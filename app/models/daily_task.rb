class DailyTask < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :title, presence: true
  validates :date, presence: true
  validate :max_three_per_day

  def max_three_per_day
    if date.present? && goal_id.present?
      count = DailyTask.where(user_id: user_id, goal_id: goal_id, date: date).where.not(id: id).count
       if count >= 3
        errors.add(:base, "1日に作成できるタスクは3件までです")
       end
    end
  end
end
