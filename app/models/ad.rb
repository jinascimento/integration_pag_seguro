# == Schema Information
#
# Table name: ads
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  description          :text
#  category_id          :integer
#  member_id            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  price_cents          :integer          default(0)
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  finish_date          :date
#  description_md       :text
#  description_short    :text
#

class Ad < ActiveRecord::Base

  # Constants
  QTD_PER_PAGE = 6
  # RatyRate GEM
  ratyrate_rateable "quality"
  #Callbacks
  before_save :md_to_html

  # Associations
  belongs_to :category, counter_cache: true
  belongs_to :member
  has_many :comments

  # Validates
  validates :title, :description_md, :description_short, :category, :picture, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0 }

   # Scope
  scope :descending_order, ->(page) {
    order(created_at: :desc).page(page).per(QTD_PER_PAGE)
  }
  scope :ad_for_current_member, ->(member) { where(member: member)}
  scope :by_category, -> (id, page)  { where(category: id).page(page).per(QTD_PER_PAGE)}
  scope :search, -> (term) {
    where("lower(title) LIKE ?", "%#{term.downcase}%").page(page).per(QTD_PER_PAGE)
  }

  # paperclip
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  # Gem Money-rails
  monetize :price_cents

  private
    def md_to_html
      options = {
          filter_html: true,
          link_attributes: {
              rel: "nofollow",
              target: "_blank"
          }
      }

      extensions = {
          space_after_headers: true,
          autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      self.description = markdown.render(self.description_md)
    end

end
