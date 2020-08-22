class Record < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :hour, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24 }
  validates :content, length: { maximum: 1000, too_long: "最大1000文字まで使えます" }
  validates :memo, length: { maximum: 1000, too_long: "最大1000文字まで使えます" }
  validates :study, length: { maximum: 3000, too_long: "最大3000文字まで使えます" }
end
