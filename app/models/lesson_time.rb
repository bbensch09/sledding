class LessonTime < ActiveRecord::Base
  has_many :lessons
  has_many :calendar_blocks
  has_many :users, through: :lessons

  validates :date, presence: true

  def self.find_morning_slot(date)
    LessonTime.find_by_date_and_slot(date, 'Morning')
  end

  def self.find_afternoon_slot(date)
    LessonTime.find_by_date_and_slot(date, 'Afternoon')
  end

  def non_weekend?
    day_of_week = self.date.strftime('%A')
    non_night_sledding_days = ['Sunday','Monday','Tuesday','Wednesday','Thursday']
    if non_night_sledding_days.include?(day_of_week) && !SPECIAL_NIGHT_SLEDDING_DATES.include?(self.date.to_s)
      return true 
    else
      return false
    end
  end
end
