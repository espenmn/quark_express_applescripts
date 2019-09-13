(*
	Copyright (c) Espen Moe-Nilssen
*)

tell application "QuarkXPress 2018"
	activate
	
	set a to color specs of document 1 as list
	
		set stylelist to []	
	if (count of a) < 15 then
		repeat with i from 1 to count of a
			try
				set b to name of item i of a
				set stylelist to stylelist & b
			end try
		end repeat
	end if
	
	if (count of a) > 14 then

		repeat with i from 1 to count of a
			try
				set navn to name of item i of a as string
				if first character of navn is ":" then
					set b to name of item i of a
					set stylelist to stylelist & b
				end if
			end try
		end repeat
		
			set stylelist to stylelist & ["Svart", "Magenta", "Cyan", "Gul"]	
	end if
	
	set colorname to choose from list stylelist with prompt "Box Color"
	set colorname to colorname as string
	
	set color of current box to colorname
	
end tell