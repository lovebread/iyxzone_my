class PollAnswerObserver < ActiveRecord::Observer

#  def after_create answer
#    @poll = Poll.find(answer.poll_id)
#    unless  @poll.update_attribute(:verified, 0)
#      render :update do |page|
#        page << "error('发生错误:');"
#      end
#    end
#  end

end