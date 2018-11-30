(*
	Copyright (c) Espen Moe-Nilssen
*)

tell application "QuarkXPress 2018"
	activate
	
	set a to color specs of document 1 as list
	
	set stylelist to []
	repeat with i from 1 to count of a
		try
			set b to name of item i of a
			set stylelist to stylelist & b
		end try
	end repeat
	
	set colorname to choose from list stylelist with prompt "velg rammefarge"
	set colorname to colorname as string
	
	set color of frame of current box to colorname
	
end tell