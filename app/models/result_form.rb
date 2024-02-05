class ResultForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :play_id, :integer
  attribute :opponent_id, :integer
  attribute :match_result
  attribute :challenges
  attribute :comment

  def self.initialize_by_params(params)
    play_id = params[:play_id].to_i
    opponent_id = params[:opponent_id].to_i
    challenges = params[:challenges].to_h { |k, v| [k.to_i, v.to_sym] }
    match_result = params[:match_result]
    comment = params[:comment].strip

    self.new(play_id:, opponent_id:, challenges:, match_result:, comment:)
  end

  def save_result!
    ActiveRecord::Base.transaction do
      play_result = create_result!
      create_challenges!(play_result)
    end
  end

  private

    def play
      @play ||= Play.find(play_id)
    end

    def create_challenges!(play_result)
      challenges.each do |challenge_id, result|
        play_result.challenge_results.create!(challenge_id:, result:)
      end
    end

    def create_result!
      result =
        case match_result
        when "WIN", "LOSE"
          match_result.downcase.to_sym
        else
          :no_contest
        end

      play.results.create!(opponent_id:, result:, comment:)
    end
end
