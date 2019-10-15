class Cause < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :donations, dependent: :destroy

  validates :title, presence: true, length: {maximum: 140}
  validates :end_time, presence: true
  validates :detail, presence: true
  validate :check_time

  scope :sort_by_created, ->{order created_at: :desc}
  scope :recent_post, -> {limit 3}

  def check_time
    if end_time < Date.today
      errors.add(:end_time, t("cause.model.errorTime"))
    end
  end
end
