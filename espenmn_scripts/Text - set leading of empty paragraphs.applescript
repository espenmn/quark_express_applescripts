(*
	Set leading for empty lines empty lines
	EMN 2020
*)


tell application "QuarkXPress 2018"
	activate
	
	
	set leadingquestion to display dialog "Leading for empty lines" default answer "10pt"
	set leadint to text returned of leadingquestion
	
	tell selection
		repeat with i from (count of paragraphs) to 1 by -1
			-- display dialog (count of characters of paragraph i)
			if (count of characters of paragraph i) = 1 then
				try
					set leading of paragraph i to leadint
				end try
			end if
		end repeat
		display dialog "DONE"
	end tell
end tell
