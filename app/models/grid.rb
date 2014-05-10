class Grid < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  has_many :coordinates
end
