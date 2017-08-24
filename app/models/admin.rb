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
