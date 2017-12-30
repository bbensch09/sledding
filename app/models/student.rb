class Student < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :requester, class_name: 'User', foreign_key: 'requester_id'

  validates :name, :age_range, :gender, :relationship_to_requester, :most_recent_level, presence: true
  validates :age, numericality: { greater_than: 7 }

  # validate :meets_age_minimum

  # def meets_age_minimum
  # 	age_range.to_i >= 8
  # end

end
