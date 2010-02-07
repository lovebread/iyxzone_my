class Admin::PhotoTagsController < AdminBaseController

  def index
    @photo_tags = Photo_tag.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @photo_tag = Photo_tag.find(params[:id])
    unless @photo_tag
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 照片不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @photo_tag = Photo_tag.find(params[:id])
    unless @photo_tag
      render :update do |page|
        page << "error('发生错误: 照片不存在');"
      end
    else
      @photo_tag.verified = 1
      if @photo_tag.update_attributes(params[:photo_tag])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_photo_tags_url
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
     @photo_tag = Photo_tag.find(params[:id])
    unless @photo_tag
      render :update do |page|
        page << "error('发生错误: 照片不存在');"
      end
    else
      @photo_tag.verified = 2
      if @photo_tag.update_attributes(params[:photo_tag])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_photo_tags_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end