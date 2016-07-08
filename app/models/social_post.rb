class SocialPost < ActiveRecord::Base
  validates :service_id, uniqueness: { scope: :service }
end
