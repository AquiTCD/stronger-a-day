class Users::FavoriteCharactersController < ApplicationController
  def edit
    @characters = Character.all.includes(:game).order(:kana)
    @fav_ids = current_user.favorite_characters.pluck(:character_id)
  end

  def update
    ActiveRecord::Base.transaction do
      # 画面から来たものに以外（=選択されなかったもの）があれば削除
      deleting = current_user.favorite_characters.where.not(character_id: update_params[:character_ids]&.map(&:to_i))
      deleting.each(&:destroy!) if deleting.present?

      # 増えたものを追加
      existing_situation_ids = current_user.favorite_characters.pluck(:character_id)
      update_params[:character_ids]&.each do |c_id|
        id = c_id.to_i
        next if existing_situation_ids.include?(id)

        current_user.favorite_characters.create!(character_id: c_id)
      end
    end
    redirect_to edit_favorite_characters_path, flash: { success: "更新しました" }
  end

  private

    def update_params
      params.permit(character_ids: [])
    end
end
