(*
	Set leading for empty lines empty lines
	EMN 2020
*)


tell application "QuarkXPress 2018"
	activate
	
	
	set a to style specs of document 1 as list
	
	set stylelist to []
	repeat with i from 1 to count of a
		try
			set b to name of item i of a
			set stylelist to stylelist & b
		end try
		
	end repeat
	
	set leadingquestion to display dialog "Leading for empty lines" default answer "10pt"
	set leadint to text returned of leadingquestion
	
	set first_style to choose from list stylelist with prompt "Find stylesheet"
	
	
	set first_style to first_style as string
	
	
	tell selection
		repeat with i from (count of paragraphs) to 1 by -1
			-- display dialog (count of characters of paragraph i)
			if (count of characters of paragraph i) = 1 then
				try
					set leading of paragraph i to leadint
				 
							set style sheet of (paragraph i) to first_style
					 
					
				end try
			end if
		end repeat
		display dialog "DONE"
	end tell
end tell
