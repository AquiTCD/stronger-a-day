namespace :recount do
  desc "Challenge#referred_count を再集計"
  task challenge_referred: :environment do
    Challenge::Reference.counter_culture_fix_counts
  end
end
