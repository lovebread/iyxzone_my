class Admin::EventsController < AdminBaseController

  def index
    @events = Event.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @event = Event.find(params[:id])
    unless @event
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 活动不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @event = Event.find(params[:id])
    unless @event
      render :update do |page|
        page << "error('发生错误: 活动不存在');"
      end
    else
      @event.verified = 1
      if @event.update_attributes(params[:event])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_events_url
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
     @event = Event.find(params[:id])
    unless @event
      render :update do |page|
        page << "error('发生错误: 活动不存在');"
      end
    else
      @event.verified = 2
      if @event.update_attributes(params[:event])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_events_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end