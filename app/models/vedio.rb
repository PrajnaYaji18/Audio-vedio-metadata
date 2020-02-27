class Vedio < Media
	def duration_tc(milisecs)
	seconds = ( milisecs.to_i )/1000
	Time.at(seconds).utc.strftime("%H:%M:%S")
	end

end
