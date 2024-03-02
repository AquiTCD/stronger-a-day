namespace :hotfix do
  desc "無駄に重複してしまってたSystemのチャレンジを削除"
  task delete_duplicate_challenges: :environment do
    puts "start to delete duplicate challenges..."

    User.system.challenges.where("id > ?", 5).each do |challenge|
      refs = Challenge::Reference.where(from: challenge)
      to_ids = refs.pluck(:to_id).uniq
      Challenge.where(id: to_ids).destroy_all
      challenge.destroy
    end

    puts "done!"
  end
end
