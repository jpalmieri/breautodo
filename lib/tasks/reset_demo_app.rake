task reset_demo_app: :environment do
  # clean demo app from lists and users (except those created in the last 30 minutes)
  if ENV['DEMO'] == 'true'
    [List, User.where.not(email: "demo@example.com")].each do |item|
      item.where("created_at < ?", Time.now - 30.minutes).destroy_all
    end
  else
    puts "task aborted! this should only be run in the demo app!"
  end
end
