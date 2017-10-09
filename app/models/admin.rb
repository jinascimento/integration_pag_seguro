# == Schema Information
#
# Table name: admins
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
#  name                   :string
#  role                   :integer
#

class Admin < ActiveRecord::Base
  #Constantes
  ROLES = { :full_access => 0, :restricted_access => 1 }
  
  #Enums
  enum role: ROLES
    
  #Scope utilizado para query que serão bastante utilizadas, reutilização
  scope :with_full_access, -> { where(role: ROLES[:full_access] ) }
  scope :with_restricted_access, -> { where(role: ROLES[:restricted_access] ) }
  
  # Alternativa para scope
  #def self.with_full_access
  #  where(role: 'full_access')
  #end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
end
