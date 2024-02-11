# == Schema Information
#
# Table name: training_results
#
#  id          :bigint           not null, primary key
#  training_id :bigint           not null
#  comment     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_training_results_on_training_id  (training_id)
#
# Foreign Keys
#
#  fk_rails_...  (training_id => trainings.id)
#
class Training::Result < ApplicationRecord
  belongs_to :training
end
