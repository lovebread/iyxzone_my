class User::MailSettingController < UserBaseController

  layout 'app'

  def edit
  end

  def update
    if @setting.update_attributes(params[:setting])
      flash.now[:notice] = "succeeded"
      render :action => 'edit'
    else
      render :action => 'edit'
    end
  end

protected

  def catch_setting
    @setting = current_user.mail_setting
  end

end
