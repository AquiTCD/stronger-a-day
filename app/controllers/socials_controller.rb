class SocialsController < BaseController
  def challenges
    challenges =
      Challenge.where.not(user: [User.system, current_user]).where(game: @game).in_public
    challenges = challenges.where(character_id: params[:character_id]) if params[:character_id].present?
    challenges = challenges.where(opponent_id: params[:opponent_id]) if params[:opponent_id].present?
    @challenges =
      challenges.where.missing(:referred_from).order("RANDOM()").
        includes(:user, referred_tos: :user).limit(25)
    @characters = @game.characters
  end

  def trainings
    trainings =
      Training.where.not(user: [User.system, current_user]).where(game: @game).in_public
    trainings = trainings.where(character_id: params[:character_id]) if params[:character_id].present?
    # @trainings =
    #   trainings.where.missing(:referred_from).order("RANDOM()").
    #     includes(:referred_tos).limit(25)
    @trainings = trainings.includes(:user, recipe: { recipe_situations: :situation }).order("RANDOM()").limit(25)
    @characters = @game.characters
  end

  def recipes
    recipes =
      Recipe.where.not(user: [User.system, current_user]).where(game: @game).in_public
    recipes = recipes.where(character_id: params[:character_id]) if params[:character_id].present?
    # @recipes =
    #   recipes.where.missing(:referred_from).order("RANDOM()").
    #     includes(:referred_tos).limit(25)
    @recipes = recipes.includes(:user, recipe_situations: :situation).order("RANDOM()").limit(25)
    @characters = @game.characters
  end

  def copy_challenge
    challenge = Challenge.find(params[:challenge_id])
    challenge.copy_to(current_user)
    redirect_to challenges_game_social_path(@game), flash: { success: "チャレンジをコピーしました" }
  end
end
