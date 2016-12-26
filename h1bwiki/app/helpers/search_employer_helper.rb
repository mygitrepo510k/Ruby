module SearchEmployerHelper
	def overview_item label, val, yr=0
		if label == :h1b_prev			
			return raw("<div class='res-box val-green'><p>Filed H-1B in#{val}out of last #{yr} years</p></div>") if val == 3
			return raw("<div class='res-box val-yellow'><p>Filed H-1B in#{val}out of last #{yr} years</p></div>") if val == 2 || val == 1
			return raw("<div class='res-box val-red'><p>Filed H-1B in#{val}out of last #{yr} years</p></div>") if val == 0
		elsif label == :h1b_rate
			return raw("<div class='res-box val-green'><p>#{val}% H-1B Approval Rate in last #{yr} years</p></div>") if val >= 80
			return raw("<div class='res-box val-yellow'><p>#{val}% H-1B Approval Rate in last #{yr} years</p></div>") if val >= 30
			return raw("<div class='res-box val-red'><p>#{val}% H-1B Approval Rate in last #{yr} years</p></div>") if val < 30 
		elsif label == :everified
			val = val.downcase
			return raw("<div class='res-box val-green' style='width:100px;'><p>#{val.upcase}</p></div>") if val=="good" || val == "yes"
			return raw("<div class='res-box val-yellow' style='width:100px;'><p>#{val.upcase}</p></div>") if val=="neutral"
			return raw("<div class='res-box val-red' style='width:100px;'><p>#{val.upcase}</p></div>") if val=="no" || val == "bad"
		elsif label == :prevgccount
			return raw("<div class='res-box val-green'><p>Filed GC in #{val} out of last #{yr} years</p></div>") if val >= 3
			return raw("<div class='res-box val-yellow'><p>Filed GC in #{val} out of last #{yr} years</p></div>") if val == 2 || val == 1
			return raw("<div class='res-box val-red'><p>Filed GC in #{val} out of last #{yr} years</p></div>") if val == 0
		elsif label == :gc_approval_rate
			return raw("<div class='res-box val-green'><p>#{val}% GC Approval Rate in last #{yr} years</p></div>") if val >= 80
			return raw("<div class='res-box val-yellow'><p>#{val}% GC Approval Rate in last #{yr} years</p></div>") if val >= 30
			return raw("<div class='res-box val-red'><p>#{val}% GC Approval Rate in last #{yr} years</p></div>") if val < 30 
		end
		return false
	end
end
