# == Schema Information
#
# Table name: challenge_references
#
#  id         :bigint           not null, primary key
#  from_id    :bigint
#  to_id      :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_challenge_references_on_from_id            (from_id)
#  index_challenge_references_on_from_id_and_to_id  (from_id,to_id) UNIQUE
#  index_challenge_references_on_to_id              (to_id)
#
# Foreign Keys
#
#  fk_rails_...  (from_id => challenges.id)
#  fk_rails_...  (to_id => challenges.id)
#

class Challenge::Reference < ApplicationRecord
  belongs_to :from, class_name: "Challenge", optional: true
  belongs_to :to, class_name: "Challenge", counter_cache: true

  validates :from_id, uniqueness: { scope: :to_id }
end
