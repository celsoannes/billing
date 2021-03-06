#class User < ApplicationRecord
#  # Include default devise modules. Others available are:
#  # :confirmable, :lockable, :timeoutable and :omniauthable
#  devise :ldap_authenticatable, :registerable,
#         :recoverable, :rememberable, :trackable, :validatable
#end
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true
  before_validation :get_ldap_email
  def get_ldap_email
    self.email =
        Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
  end
  # use ldap uid as primary key
  before_validation :get_ldap_id
  def get_ldap_id
    self.id =
        Devise::LDAP::Adapter.get_ldap_param(self.username,"uidnumber").first
  end
  # hack for remember_token
  def authenticatable_token
    Digest::SHA1.hexdigest(email)[0,29]
  end
end
