# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  description :string(60)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ads_count   :integer          default(0)
#

class Category < ActiveRecord::Base
  # Gem Friendly Id
  include FriendlyId
  friendly_id :description, use: :slugged

  # Associations
  has_many :ads

  # Validations
  validates_presence_of :description

  # Scope
  scope :order_by_description, -> { order(:description) }
end
