class Admin::TagsController < AdminBaseController

  def index
    @tags = Tag.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @tag = Tag.find(params[:id])
    unless @tag
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 标签不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @tag = Tag.find(params[:id])
    unless @tag
      render :update do |page|
        page << "error('发生错误: 标签不存在');"
      end
    else
      @tag.verified = 1
      if @tag.update_attributes(params[:tag])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_tags_url
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
     @tag = Tag.find(params[:id])
    unless @tag
      render :update do |page|
        page << "error('发生错误: 标签不存在');"
      end
    else
      @tag.verified = 2
      if @tag.update_attributes(params[:tag])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_tags_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end