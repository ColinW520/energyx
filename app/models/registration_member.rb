class RegistrationMember < ActiveRecord::Base
  belongs_to :registration

  validates :name, presence: true
  validates :email, presence: true
end
