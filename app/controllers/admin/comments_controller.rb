class Admin::CommentsController < AdminBaseController

  def index
    @comments = Comment.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @comment = Comment.find(params[:id])
    unless @comment
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 评论不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @comment = Comment.find(params[:id])
    unless @comment
      render :update do |page|
        page << "error('发生错误: 评论不存在');"
      end
    else
      @comment.verified = 1
      if @comment.update_attributes(params[:comment])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_comments_url
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
     @comment = Comment.find(params[:id])
    unless @comment
      render :update do |page|
        page << "error('发生错误: 评论不存在');"
      end
    else
      @comment.verified = 2
      if @comment.update_attributes(params[:comment])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_comments_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end
