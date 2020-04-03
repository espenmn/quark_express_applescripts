(*
	Copyright (c) Espen Moe-Nilssen
*)

tell application "QuarkXPress 2018"
	activate
	
	set result to display dialog "By how many" default answer 2
	set cc to text returned of result as number
	tell selection
		repeat with i from 1 to 300
			set b to count of words of paragraph i
			try
				set a to contents of paragraph i
				set c to contents of last word of a as integer
				set b to c + cc
				
				set contents of last word of paragraph i to b
				set color of last word of paragraph i to "Magenta"
			end try
		end repeat
	end tell
end tell