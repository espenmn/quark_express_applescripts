(*
	Copyright (c) Espen Moe-Nilssen
*)

tell application "QuarkXPress 2018"
	activate
	
	
	tell document 1
		repeat with i from 1 to 300
			
			set b to count of words of paragraph i of text box 1
			set a to contents of paragraph i of text box 1
			set c to contents of last word of a as integer
			set b to c + 2
			
			set last word of paragraph i of text box 1 to b
			set color of last word of paragraph i of text box 1 to "Magenta"
			
		end repeat
	end tell
end tell