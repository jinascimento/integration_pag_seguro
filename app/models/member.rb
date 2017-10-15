# == Schema Information
#
# Table name: members
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Member < ActiveRecord::Base
  # Ratyrate Gem
  ratyrate_rater

  # Associations
  has_one :profile_member
  has_many :ads
  accepts_nested_attributes_for :profile_member

  # Validations
  validate :nested_attributes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def nested_attributes
    if nested_attributes_blank?
      errors.add(:base , "É necessário preencher os campos Primeiro e segundo nome.")
    end
  end

  def nested_attributes_blank?
    profile_member.first_name.blank? ||
    profile_member.second_name.blank?
  end
end
