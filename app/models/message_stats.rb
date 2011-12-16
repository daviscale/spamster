class MessageStats

  def self.stats
    stats = Rails.cache.fetch(:stats_store) { initialize_stats }
    return stats
  end

  def self.initialize_stats
    # "cat" is short for category
    # This classifier only has 2 categories - Relevant and Spam
    stats = {}

    stats[:word_total] = 0.0
    stats[:cat_totals] = {}
    stats[:cat_totals][:relevant] = 0.0
    stats[:cat_totals][:spam] = 0.0

    stats[:word_cat_totals] = {}
    stats[:word_cat_totals][:relevant] = Hash.new(0.0)
    stats[:word_cat_totals][:spam] = Hash.new(0.0)

    Message.find_each do |message|
      stats = self.compile_words(stats, message, 1)
    end

    return stats
  end

  def self.decrement_stats(message)
    self.update_stats(message, -1)
  end

  def self.increment_stats(message)
    self.update_stats(message, 1)
  end

  def self.refresh_stats
    Rails.cache.write(:stats_store, initialize_stats)
  end

  private
    def self.update_stats(message, multiplier)
      previous_stats = self.stats.dup

      stats = self.compile_words(previous_stats, message, multiplier)

      Rails.cache.write(:stats_store, stats)
    end

    def self.compile_words(stats, message, multiplier)
      if message.status_str.eql?("Relevant")
        status = :relevant
      else
        status = :spam
      end

      content = message.content.sub(/#java/, "")
      content = content.sub(/https{,1}:\/\/\S* /, "")

      msg_words = content.split(/\W/)

      msg_words.each do |word|
        stats[:word_total] = stats[:word_total] + (1.0 * multiplier)
        stats[:cat_totals][status] = stats[:cat_totals][status] + (1.0 * multiplier)
        stats[:word_cat_totals][status][word] = stats[:word_cat_totals][status][word] + (1.0 * multiplier)
      end

      return stats
    end

end # class MessageStats
