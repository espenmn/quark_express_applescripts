(*
	Copyright (c) Espen Moe-Nilssen 2020
	Should be possible to do this faster (with every character whose content is)
	but did not figure it out
*)

tell application "QuarkXPress 2018"
	activate
	repeat with i from 1 to count of characters of selection
		if character i of selection is "	" then
			set size of character i of selection to "6pt"
		end if
	end repeat
	display dialog "Done"
	
end tell