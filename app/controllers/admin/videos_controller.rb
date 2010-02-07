class Admin::VideosController < AdminBaseController

  def index
    @videos = Video.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @video = Video.find(params[:id])
    unless @video
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 视频不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @video = Video.find(params[:id])
    unless @video
      render :update do |page|
        page << "error('发生错误: 视频不存在');"
      end
    else
      @video.verified = 1
      if @video.update_attributes(params[:video])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_videos_url
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
     @video = Video.find(params[:id])
    unless @video
      render :update do |page|
        page << "error('发生错误: 视频不存在');"
      end
    else
      @video.verified = 2
      if @video.update_attributes(params[:video])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_videos_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end
