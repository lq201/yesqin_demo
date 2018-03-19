class SeoUrlWorker
  include Sidekiq::Worker

  def perform
    TestPost.all.each do |post|
      seo_url = PinYin.of_string(post.post_title).join('-')
      post.update_attributes(seo_url: seo_url)
    end
  end
end
