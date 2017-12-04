module LabsHelper
  def timeline
    [find_lab_observations, find_lab_questions, find_lab_hypotheses].flatten.sort_by(&:created_at).reverse
  end

  def find_lab_observations
    if @related_observations == []
      if lab_parent?
        Lab.where(parent: @lab.id)
      else
        []
      end
    else
      @related_observations
    end
  end

  def find_lab_questions
    if @lab.questions == []
      if lab_parent?
        Question.where(lab_id: @lab.id)
      else
        []
      end
    else
      @lab.questions
    end
  end

  def find_lab_hypotheses
      Hypothesis.where(lab_id: @lab.id)
  end

  def lab_parent?
    @lab.parent != nil
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
