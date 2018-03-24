class DashboardController < ApplicationController
  def welcome
    @setting = Setting.first
  end

  def posts
    @posts = TestPost.all
  end

  def save_setting
    @setting = Setting.find_by(id: params[:id])
    @setting.update(setting_params)
  end

  def send_email
    MailerJob.perform_async(params[:address])
    render json: {status: 200, msg: '邮件已经发送，请注意查收。'}
  end

  def save_frequency
    setting = Setting.find_by(id: params[:id])
    if setting.blank?
      render json: {status: 404, msg: '找不到设置对象！'}
    elsif params[:frequency].to_i < 1
      render json: {status: 500, msg: '最小频率不能小于1分钟'}
    else
      if setting.update_attributes(frequency: params[:frequency])
        scheduler = Sidekiq::ScheduledSet.new
        # 删除所有旧的schedule job
        old_jobs = scheduler.select {|work| work.klass == 'SeoUrlWorker' }
        old_jobs.each(&:delete) if old_jobs.present?

        SeoUrlWorker.perform_in(setting.frequency.minutes)

        render json: {status: 200, msg: '频率更新成功。'}
        scheduler = Sidekiq::ScheduledSet.new
        # 删除所有旧的schedule job
        old_jobs = scheduler.select {|work| work.klass == 'SeoUrlWorker' }.sort
        old_jobs.each(&:delete) if old_jobs.present?

        SeoUrlWorker.perform_in(setting.frequency.minutes)
      else
        render json: {status: 500, msg: '频率更新失败。'}
      end
    end
  end

  def send_sms
    SendSmsWorker.perform_async(params[:phone_number])
    render json: {status: 200, msg: '短信已经发送，请注意查收。'}
  end

  def clear_seo_url
    TestPost.update_all(seo_url: nil)
    render json: {status: 200, msg: "所有#{t('posts.seo_url')}已经被清除"}
  end

  private

  def setting_params
    params.require(:setting).permit(:frequency)
  end
end
