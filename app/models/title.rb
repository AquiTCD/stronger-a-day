# == Schema Information
#
# Table name: titles
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_titles_on_name  (name) UNIQUE
#
class Title < ApplicationRecord
  has_many :characters, dependent: :destroy
end
