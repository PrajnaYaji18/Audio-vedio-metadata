# frozen_string_literal: true

class Audio < Media
  def duration_tc(duration)
    miliseconds = duration.to_i % 1000
    seconds = duration.to_i / 1000
    time = Time.at(seconds).utc.strftime('%H:%M:%S')
    time.to_s + ':' + miliseconds.to_s
    end
end
