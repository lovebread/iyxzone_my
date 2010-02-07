class Admin::SharingsController < AdminBaseController

  def index
    @sharings = Sharing.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @sharing = Sharing.find(params[:id])
    unless @sharing
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 分享不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @sharing = Sharing.find(params[:id])
    unless @sharing
      render :update do |page|
        page << "error('发生错误: 分享不存在');"
      end
    else
      @sharing.verified = 1
      if @sharing.update_attributes(params[:sharing])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_sharings_url
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
     @sharing = Sharing.find(params[:id])
    unless @sharing
      render :update do |page|
        page << "error('发生错误: 分享不存在');"
      end
    else
      @sharing.verified = 2
      if @sharing.update_attributes(params[:sharing])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_sharings_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end