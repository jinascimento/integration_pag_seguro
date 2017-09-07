class Ad < ActiveRecord::Base
  belongs_to :category
  belongs_to :member

   # Scope
  scope :descending_order, ->(quantify = 10) { limit(quantify).order(created_at: :desc) }
  scope :ad_for_current_member, ->(member) { where(member: member)}
  # paperclip
  has_attached_file :picture, styles: { medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  # Gem Money-rails
  monetize :price_cents

end
