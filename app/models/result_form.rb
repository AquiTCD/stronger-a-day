class ResultForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :daily_id, :integer
  attribute :opponent_id, :integer
  attribute :result
  attribute :challenges

  def self.initialize_by_params(params)
    daily_id = params[:daily_id].to_i
    opponent_id = params[:opponent_id].to_i
    challenges = params[:challenges].to_h { |k, v| [k.to_i, v.to_sym] }
    result = params[:result].downcase.to_sym

    self.new(daily_id:, opponent_id:, challenges:, result:)
  end

  def save_result!
    ActiveRecord::Base.transaction do
      convert_to_daily_challenge
      convert_to_daily_result
    end
  end

  private

    def daily
      @daily ||= Daily.find(daily_id)
    end

    def convert_to_daily_challenge
      challenges.each do |challenge_id, result|
        daily_challenge = daily.daily_challenges.find_or_initialize_by(challenge_id:)
        case result
        when :success
          daily_challenge.success_count += 1
        when :failure
          daily_challenge.failure_count += 1
        end
        daily_challenge.save!
      end
    end

    def convert_to_daily_result
      daily_result = daily.daily_results.find_or_initialize_by(opponent_id:)
      case result
      when :win
        daily_result.win_count += 1
      when :lose
        daily_result.lose_count += 1
      end
      daily_result.save!
    end
end
