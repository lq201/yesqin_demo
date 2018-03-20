class SeoUrlWorker
  include Sidekiq::Worker

  def perform
    # 更新所有TestPost的seo_url
    TestPost.all.each do |post|
      seo_url = PinYin.of_string(post.post_title).join('-')
      next if post.seo_url == seo_url
      post.update_attributes(seo_url: seo_url)
    end
    # 添加新的job到scheduler
    setting = Setting.first
    SeoUrlWorker.perform_in(setting.frequency.minutes)
  end
end
