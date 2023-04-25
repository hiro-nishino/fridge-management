class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :recipes
         has_one :fridge

  validates :nickname, presence: true


  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  after_create :create_fridge

  private

  def create_fridge
    Fridge.create(user: self)
  end
end
