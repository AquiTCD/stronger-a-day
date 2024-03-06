class SocialsController < BaseController
  def challenges
    challenges =
      Challenge.where.not(user: [User.system, current_user]).where(game: @game).in_public
    challenges = challenges.where(character_id: params[:character_id]) if params[:character_id].present?
    challenges = challenges.where(opponent_id: params[:opponent_id]) if params[:opponent_id].present?
    @challenges =
      challenges.where.missing(:referred_from).order("RANDOM()").
        includes(:user, :character, :opponent).limit(25)
    @characters = @game.characters
  end

  def trainings
    trainings =
      Training.where.not(user: [User.system, current_user]).where(game: @game).in_public
    trainings = trainings.where(character_id: params[:character_id]) if params[:character_id].present?
    # @trainings =
    #   trainings.where.missing(:referred_from).order("RANDOM()").
    #     includes(:referred_tos).limit(25)
    @trainings = trainings.includes(:user, :character, recipe: [:situations, :character, { recipe_situations: :situation }]).order("RANDOM()").limit(25)
    @characters = @game.characters
  end

  def recipes
    recipes =
      Recipe.where.not(user: [User.system, current_user]).where(game: @game).in_public
    recipes = recipes.where(character_id: params[:character_id]) if params[:character_id].present?
    @recipes =
      recipes.where.missing(:referred_from).order("RANDOM()").
        includes(:user, :character, :situations, recipe_situations: :situation).limit(25)
    @characters = @game.characters
  end

  def copy_challenge
    challenge = Challenge.find(params[:challenge_id])
    challenge.copy_to(current_user)
    flash.now[:success] = "チャレンジをコピーしました"
    render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
  end

  def copy_recipe
    recipe = Recipe.find(params[:recipe_id])
    recipe.copy_to(current_user)
    flash.now[:success] = "レシピをコピーしました"
    render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
  end
end
