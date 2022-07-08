# frozen_string_literal:true

# Gets the general time of day
module Timegreet
  T = Time.now

  def self.what_time?
    case T.hour
    when 4...12
      'morning'
    when 12
      'day'
    when 12...19
      'afternoon'
    else
      'evening'
    end
  end

  def self.say_hi
    "Good #{what_time?}!"
  end
end
