# == Schema Information
#
# Table name: games
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  abbreviation :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_games_on_abbreviation  (abbreviation) UNIQUE
#  index_games_on_title         (title) UNIQUE
#
class Game < ApplicationRecord
  has_many :characters, dependent: :destroy
  has_many :situations, dependent: :destroy

  def to_param
    abbreviation
  end
end
