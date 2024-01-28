class SaveResult
  include Interactor

  # ResultFormを受け取り、daily_result, daily_challenge を作成する
  #
  # @param [ResultForm]

  def call
    # validate!
    ActiveRecord::Base.transaction do
      convert_to_daily_challenge
      convert_to_daily_result
    end

    context
  end

  private

    def daily
      @daily ||= Daily.find(context.result_form.daily_id)
    end

    def convert_to_daily_challenge
      context.result_form.challenges.each do |challenge_id, result|
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
      daily_result = daily.daily_results.find_or_initialize_by(opponent_id: context.result_form.opponent_id)
      case result
      when :win
        daily_result.win_count += 1
      when :lose
        daily_result.lose_count += 1
      end
      daily_result.save!
    end
end
