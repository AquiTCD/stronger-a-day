class HomeController < ApplicationController
  def show
    # TODO: お気に入りのタイトルまたは選択したタイトルに対応する
    @game = Game.find_by(name: "STREET FIGHTER 6")
  end
end
