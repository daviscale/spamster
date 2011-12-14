class MessageStatsController < ApplicationController
  # GET /message_stats/refresh
  # This is a utility service for app administrators to refresh the stats cache if needed
  def refresh
    MessageStats.refresh_stats
    redirect_to "/"
  end

  #GET /message_stats/show
  def show
    @stats = MessageStats.stats
    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
