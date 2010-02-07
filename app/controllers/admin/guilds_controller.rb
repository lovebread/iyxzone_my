class Admin::GuildsController < AdminBaseController

  def index
    @guilds = Guild.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @guild = Guild.find(params[:id])
    unless @guild
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 工会不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @guild = Guild.find(params[:id])
    unless @guild
      render :update do |page|
        page << "error('发生错误: 工会不存在');"
      end
    else
      @guild.verified = 1
      if @guild.update_attributes(params[:guild])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_guilds_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 审核失败!');"
      end
      end
    end
  end
  
  # 屏蔽文章
  def unverify
     @guild = Guild.find(params[:id])
    unless @guild
      render :update do |page|
        page << "error('发生错误: 工会不存在');"
      end
    else
      @guild.verified = 2
      if @guild.update_attributes(params[:guild])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_guilds_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end