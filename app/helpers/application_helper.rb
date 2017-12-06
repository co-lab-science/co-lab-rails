module ApplicationHelper

  def get_breadcrumbs(current_post)
    current_post.get_associated_posts
  end

  def get_timeline_posts(current_post)
    current_post.get_associated_posts.values.flatten.sort_by(&:created_at).reverse
  end

  def current_post
    if self.params["controller"] == "labs"
      Lab.find(self.params["id"])
    elsif self.params["controller"] == "questions"
      Question.find(self.params["id"])
    elsif self.params["controller"] == "hypotheses"
      Hypothesis.find(self.params["id"])
    end
  end

  def find_parent_form(parent_params)
    if parent_params = nil
      binding.pry
    else
      parent_params
    end
  end

  def format_date(date)
    d = date.to_date.to_s.split("-")
    "#{d[1]}/#{d[2]}/#{d[0]}"
  end

  def time_since_creation(date)
    time_hash = TimeDifference.between(Time.now, date).in_general
    if time_hash[:years] != 0
      "#{time_hash[:years]} year(s). ago"
    elsif time_hash[:months] != 0
      "#{time_hash[:months]} month(s) ago"
    elsif time_hash[:weeks] != 0
      "#{time_hash[:weeks]} weeks(s) ago"
    elsif time_hash[:days] != 0
      "#{time_hash[:days]} days(s) ago"
    elsif time_hash[:hours] != 0
      "#{time_hash[:hours]} hours(s) ago"
    elsif time_hash[:minutes] != 0
      "#{time_hash[:minutes]} minutes(s) ago"
    elsif time_hash[:seconds] != 0
      "#{time_hash[:seconds]} seconds(s) ago"
    end
  end

end
