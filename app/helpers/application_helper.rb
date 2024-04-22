module ApplicationHelper
  def question_date question
    created_at = question.created_at
    current_time = Time.now

    seconds_elapsed = (current_time - created_at).to_i
    years = seconds_elapsed / (365 * 24 * 60 * 60)
    return "#{year} years ago" unless years <= 0
    
    seconds_elapsed %= (365 * 24 * 60 * 60)
    months = seconds_elapsed / (30 * 24 * 60 * 60)
    return "#{months} months ago" unless months <= 0
    
    seconds_elapsed %= (30 * 24 * 60 * 60)
    weeks = seconds_elapsed / (7 * 24 * 60 * 60)
    return "#{weeks} weeks ago" unless weeks <= 0
    
    seconds_elapsed %= (7 * 24 * 60 * 60)
    days = seconds_elapsed / (24 * 60 * 60)
    return "#{days} days ago" unless days <= 0
    
    seconds_elapsed %= (24 * 60 * 60)
    hours = seconds_elapsed / (60 * 60)
    return "#{hours} hours ago" unless hours <= 0
    
    seconds_elapsed %= (60 * 60)
    minutes = seconds_elapsed / 60
    return "#{minutes} minutes ago" unless minutes <= 0
    
    return "#{seconds_elapsed} seconds ago"
    
  end

  def question_answers question
    if question.answers.count == 1
      return "⇱ View 1 Answer"
    elsif question.answers.count > 1
      return "⇱ View #{ question.answers.count } Answers"
    else
      return "⇱ View Question"
    end
  end
end
