class ClassifyController < ApplicationController
  def index
  end

  def predict
    @content = Twitter.search("#java -rt", :rpp => 1, :lang => "en").first.text
    msg_words = @content.split(/\W/)
    
    stats = MessageStats.stats
    eps_prob = 1.0 / stats[:word_total]

    relevant_eps = 1.0
    spam_eps = 1.0

    relevant_counts = []
    spam_counts = []

    msg_words.each do |word|
      if (stats[:word_cat_totals][:relevant][word] == 0.0)
        relevant_eps *= eps_prob
      else
        relevant_counts.push(stats[:word_cat_totals][:relevant][word]) 
      end

      if (stats[:word_cat_totals][:spam][word] == 0.0)
        spam_eps *= eps_prob
      else
        spam_counts.push(stats[:word_cat_totals][:spam][word])
      end
    end

    post_relevant = (stats[:cat_totals][:relevant] / stats[:word_total])*(product(relevant_counts) / (stats[:cat_totals][:relevant] ** relevant_counts.length))*relevant_eps
    post_spam = (stats[:cat_totals][:spam] / stats[:word_total])*(product(spam_counts) / (stats[:cat_totals][:spam] ** spam_counts.length))*spam_eps

    logger.debug "Posterior Relevant: #{post_relevant}"
    logger.debug "Posterior Spam: #{post_spam}"

    if post_relevant > post_spam
      @prediction = "Relevant"
    else
      @prediction = "Spam"
    end

    render :action => "result"
  end

  def result
  end

  private
    def product(word_counts)
      product = 1.0
      word_counts.each { |count| product *= count }
      return product
    end
end
