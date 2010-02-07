class Admin::StatusesController < AdminBaseController

  def index
    @statuses = Status.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @status = Status.find(params[:id])
    unless @status
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 状态不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @status = Status.find(params[:id])
    unless @status
      render :update do |page|
        page << "error('发生错误: 状态不存在');"
      end
    else
      @status.verified = 1
      if @status.update_attributes(params[:status])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_statuses_url
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
     @status = status.find(params[:id])
    unless @status
      render :update do |page|
        page << "error('发生错误: 状态不存在');"
      end
    else
      @status.verified = 2
      if @status.update_attributes(params[:status])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_statuses_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end
