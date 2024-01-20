class HomeController < ApplicationController
  def show
    # TODO: お気に入りのタイトルまたは選択したタイトルに対応する
    @game = Game.find_by(title: "STREET FIGHTER 6")
  end
end
