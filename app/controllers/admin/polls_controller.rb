class Admin::PollsController < AdminBaseController

  def index
    @polls = Poll.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
    @poll = Poll.find(params[:id])
    unless @poll
      render :update do |page|
        # page << "error('发生错误');"
        page << "error('发生错误: 投票不存在');"
      end
    end
  end

  def destroy
  end

  # 审核通过
  def verify
    @poll = Poll.find(params[:id])
    unless @poll
      render :update do |page|
        page << "error('发生错误: 投票不存在');"
      end
    else
      @poll.verified = 1
      if @poll.update_attributes(params[:poll])
        render :update do |page|
          page << "alert('审核成功！');"
          page.redirect_to admin_polls_url
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
     @poll = Poll.find(params[:id])
    unless @poll
      render :update do |page|
        page << "error('发生错误: 投票不存在');"
      end
    else
      @poll.verified = 2
      if @poll.update_attributes(params[:poll])
        render :update do |page|
          page << "alert('屏蔽成功！');"
          page.redirect_to admin_polls_url
        end
      else
        render :update do |page|
        page << "error('发生错误: 屏蔽失败!');"
      end
      end
    end
  end
  
end