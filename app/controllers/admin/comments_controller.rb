class Admin::CommentsController < AdminBaseController

  def index
    @comments = Comment.unverified.paginate :page => params[:page], :per_page => 20
  end

  def show
  end
  
  def destroy
  end

  # accept
  def verify
    @comment.verified = 1
    if @comment.save
      succ
    else
      err
    end
  end
  
  # reject
  def unverify
    @comment.verified = 2
    if @comment.save
      succ
    else
      err
    end
  end
  
  
protected

  def setup
    if ["show", "destroy", "verify", "unverify"].include? params[:action]
      @comment = Comment.find(params[:id])
    end
  rescue
    not_found
  end
  
end
