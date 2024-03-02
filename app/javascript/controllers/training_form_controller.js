import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "characters", "recipes"
  ]

  connect() {
    this.allRecipes = this.recipesTarget.cloneNode(true).options
  }

  syncToCharacter(event) {
    const characterId = event.target.selectedOptions[0].dataset.characterId
    if (characterId) {
      const index = Array.from(this.charactersTarget.options).map((option) => option.value).indexOf(characterId)
      this.charactersTarget.options[index].selected = true
    }
  }

  syncToRecipe(event) {
    const recipes = Array.from(this.allRecipes)
    Array.from(this.recipesTarget.options).forEach((_r) => {
      this.recipesTarget.remove(1)
    })

    const characterId = event.target.selectedOptions[0].value
    if (characterId) {
      recipes.forEach((recipe) => {
        if (recipe.dataset.characterId === characterId) {
          this.recipesTarget.add(recipe)
        }
      })
    } else {
      recipes.forEach((recipe, i) => {
        if(i !== 0) { this.recipesTarget.add(recipe) }
      })
    }
    this.allRecipes = recipes
  }
}
