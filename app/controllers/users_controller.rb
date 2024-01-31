class UsersController < ApplicationController
  def show
    @user = User.find_by!(params[:name])
  end

  def me
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(update_params)
      redirect_to edit_me_path, flash: { success: "ユーザー情報を更新しました" }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def update_params
      params.require(:user).permit(:name, :display_name)
    end
end
