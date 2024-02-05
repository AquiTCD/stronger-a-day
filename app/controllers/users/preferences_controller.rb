class Users::PreferencesController < ApplicationController
  include Devise::Controllers::Rememberable

  def edit
    @preference = current_user.preference
    # FIXME: なぜか false になる
    @remember_me = remember_me_is_active?(current_user)
  end

  def update
    @preference = current_user.preference
    if @preference.update(pref_params)
      if remember_me_param == "1"
        current_user.remember_me!
      end
      if remember_me_param == "0"
        current_user.forget_me!
      end
      if user_description_params.present?
        current_user.update(description: user_description_params)
      end
      redirect_to edit_preference_path, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def clear_win_lose_count
    reviewed_plays = current_user.plays.reviewed.where.associated(:results).distinct
    total_results = Play::Result.where(play: reviewed_plays)
    total_results.update_all(result: :no_contest)
    alert = "全ての勝敗数をリセットしました"
    redirect_to edit_preference_path, alert:
  end

  private

    def pref_params
      params.require(:user_preference).permit(:show_tips, :show_usage, :public)
    end

    def user_description_params
      params.require(:user_preference).permit(:description)[:description]
    end

    def remember_me_param
      params.require(:user_preference).permit(:remember_me)[:remember_me]
    end
end
