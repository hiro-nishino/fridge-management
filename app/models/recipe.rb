class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  scope :search_by_title_or_tag, ->(query) {
    query = query.downcase
    joins(:tags)
    .where("LOWER(recipes.title) LIKE :query OR LOWER(tags.name) LIKE :query", query: "%#{query}%")
    .distinct
  }
  has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
  validates :serving_size, presence: true
  def tag_names
    tags.map(&:name).join(', ')
  end
  
  def tag_names=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
