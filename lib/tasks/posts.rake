namespace :posts do
  desc 'Clear up seo_url feild'
  task clear_seo_url: :environment do
    TestPost.update_all(seo_url: nil)
  end
end
