class Goal < ApplicationRecord
  belongs_to :user
  before_validation :auto_target_date

  has_many :daily_tasks, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true

  def auto_target_date
    return if start_date.blank? || target_date.present?
    self.target_date = start_date + 3.months
  end
end
