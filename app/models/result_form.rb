class ResultForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :play_id, :integer
  attribute :opponent_id, :integer
  attribute :result
  attribute :challenges

  def self.initialize_by_params(params)
    play_id = params[:play_id].to_i
    opponent_id = params[:opponent_id].to_i
    challenges = params[:challenges].to_h { |k, v| [k.to_i, v.to_sym] }
    result = params[:result].downcase.to_sym

    self.new(play_id:, opponent_id:, challenges:, result:)
  end

  def save_result!
    ActiveRecord::Base.transaction do
      convert_to_play_challenge
      convert_to_play_result
    end
  end

  private

    def play
      @play ||= Play.find(play_id)
    end

    def convert_to_play_challenge
      challenges.each do |challenge_id, result|
        play_challenge = play.play_challenges.find_or_initialize_by(challenge_id:)
        case result
        when :success
          play_challenge.success_count += 1
        when :failure
          play_challenge.failure_count += 1
        end
        play_challenge.save!
      end
    end

    def convert_to_play_result
      play_result = play.play_results.find_or_initialize_by(opponent_id:)
      case result
      when :win
        play_result.win_count += 1
      when :lose
        play_result.lose_count += 1
      end
      play_result.save!
    end
end
