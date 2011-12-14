class Message < ActiveRecord::Base
  RELEVANT = 0
  SPAM = 1

  validates :content, :presence => true
  validates :status, :presence => true

  after_destroy do |message|
    logger.debug "Decreasing stats after destroy"
    MessageStats.decrement_stats(message)
  end
  
  after_save do |message|
    logger.debug "Increasing stats after save"
    MessageStats.increment_stats(message)
  end

  def status_str
    if status.eql?(RELEVANT)
      return "Relevant"
    elsif status.eql?(SPAM)
      return "Spam"
    else
      return "Invalid Status"
    end
  end
end
