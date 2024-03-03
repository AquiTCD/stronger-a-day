class Users::PreferencesController < ApplicationController
  include Devise::Controllers::Rememberable

  def edit
    @preference = current_user.preference
    @remember_me = remember_me_is_active?(current_user)
    @reshow_tutorials = !current_user.tutorials.exists? && session[:tutorial].blank?
  end

  def update
    @preference = current_user.preference
    if @preference.update(pref_params)
      if remember_me_param == "1"
        remember_me(current_user)
      end
      if remember_me_param == "0"
        forget_me(current_user)
      end
      if user_description_params.present?
        current_user.update(description: user_description_params)
      end
      destroy_tutorials
      redirect_to edit_preference_path, flash: { success: "更新しました" }
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
      params.require(:user_preference).permit(:show_tips, :public, :default_public, :styled_movements, :show_input_pad, :keep_selection, :show_only_favorites)
    end

    def user_description_params
      params.require(:user_preference).permit(:description)[:description]
    end

    def remember_me_param
      params.require(:user_preference).permit(:remember_me)[:remember_me]
    end

    def reshow_tutorials_param
      params.require(:user_preference).permit(:reshow_tutorials)[:reshow_tutorials]
    end

    def destroy_tutorials
      if reshow_tutorials_param == "1"
        current_user.tutorials.destroy_all
        session[:tutorial] = nil if session[:tutorial]
      end
    end
end
