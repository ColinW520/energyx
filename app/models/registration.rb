class Registration < ActiveRecord::Base
  has_many :registration_members, dependent: :destroy
  accepts_nested_attributes_for :registration_members, allow_destroy: true
  alias members registration_members

  validates :name, presence: true
  validates :stripe_customer_id, presence: true
  validates :stripe_charge_id, presence: true

  def members_list
    self.registration_members.map { |member| "#{member.name} | #{member.shirt_size}" }
  end
end
