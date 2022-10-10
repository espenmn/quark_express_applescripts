(*
	Set leading for empty lines empty lines
	EMN 2020
*)


tell application "QuarkXPress 2018-kopi"
	activate
	
	
	
	set leadingquestion to display dialog "Leading for empty lines" default answer "6pt"
	set leadint to text returned of leadingquestion
	
	
	
	tell selection
		repeat with i from 1 to count of paragraphs
			-- display dialog (count of characters of paragraph i)
			if (count of characters of paragraph i) = 1 then
				try
					set leading of paragraph i to leadint
					set size of content of paragraph i to "6pt"
					
					--set style sheet of (paragraph i) to ":Blank"
					
					
				end try
			end if
		end repeat
		display dialog "DONE"
	end tell
end tell
