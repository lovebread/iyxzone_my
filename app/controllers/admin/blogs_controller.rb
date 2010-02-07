class Admin::BlogsController < AdminBaseController

  def index
    @blogs = Blog.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @blog = Blog.find(params[:id])
    unless @blog
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 博文不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @blog = Blog.find(params[:id])
    unless @blog
      render :update do |page|
        page << "error('发生错误: 博文不存在');"
      end
    else
      @blog.verified = 1
      if @blog.update_attributes(params[:blog])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_blogs_url
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
     @blog = Blog.find(params[:id])
    unless @blog
      render :update do |page|
        page << "error('发生错误: 博文不存在');"
      end
    else
      @blog.verified = 2
      if @blog.update_attributes(params[:blog])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_blogs_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end
