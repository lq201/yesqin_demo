class DashboardController < ApplicationController
  def welcome
    @setting = Setting.first
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
    else
      if setting.update_attributes(frequency: params[:frequency])
        render json: {status: 200, msg: '频率更新成功。'}
      else
        render json: {status: 500, msg: '频率更新失败。'}
      end
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:frequency)
  end
end
