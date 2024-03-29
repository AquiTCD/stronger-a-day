# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  display_name        :string
#  remember_token      :string
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :string           default(""), not null
#
# Indexes
#
#  index_users_on_display_name  (display_name) UNIQUE
#  index_users_on_name          (name) UNIQUE
#
class User < ApplicationRecord
  def self.table_name_prefix
    (self == User) ? "" : "user_"
  end

  def self.system
    find_by(name: "SYSTEM")
  end

  def to_param
    name
  end

  # for devise
  devise :authenticatable, :rememberable
  def self.new_with_session(params, session)
    user_params =
      if params.present?
        params
      else
        {
          name: session["devise.authentication"]["username"],
          display_name: session["devise.authentication"]["display_name"]
        }
      end
    new(user_params)
  end

  has_many :authentications, dependent: :destroy
  has_many :plays, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_one :preference, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :tutorials, dependent: :destroy
  has_many :trainings, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :favorite_characters, dependent: :destroy

  validates :name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_\-]+\z/ }
  validates :display_name, presence: true, uniqueness: true

  delegate(*%i[
    public show_usage show_tips default_public styled_movements
    show_input_pad keep_selection show_only_favorites
  ],
           to: :preference)

  def tutorial?(page)
    !tutorials.exists?(page:)
  end

  def selectable_characters(game)
    game_characters = game.characters
    return game_characters unless show_only_favorites

    game_characters.where(id: favorite_characters.select(:character_id)).presence ||
      game_characters
  end

  def image_url
    image_auth&.image_url || "user_placeholder.png"
  end

  private

    def image_auth
      @image_auth ||=
        authentications.find_by(provider: preference.image_provider) || authentications.first
    end
end
