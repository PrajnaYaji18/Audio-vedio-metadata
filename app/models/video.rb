class Video < Media
  def duration_tc(milisecs)
  seconds = milisecs.to_i/1000
  frames = ((milisecs.to_i - (seconds * 1000)) * 3 / 50).round 
  time = Time.at(seconds).utc.strftime("%H:%M:%S")
  return time.to_s + ":" + frames.to_s
  end
end
