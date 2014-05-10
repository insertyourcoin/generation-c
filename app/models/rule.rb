class Rule < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  has_many :grids
  include ActiveModel::ForbiddenAttributesProtection
end
