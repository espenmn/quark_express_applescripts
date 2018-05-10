tell application "QuarkXPress 2017"
	
	set a to style specs of document 1 as list
	
	set stylelist to []
	repeat with i from 1 to count of a
		set b to name of item i of a
		set stylelist to stylelist & b
		
	end repeat
	
	set first_style to choose from list stylelist with prompt "Find stylesheet"
	set next_style to choose from list stylelist with prompt "Change Next stylesheet to"
	
	set first_style to first_style as string
	set next_style to next_style as string
	
	
	tell document 1
		
		
		repeat with i from 1 to count of paragraphs of selection
			try
				set a to name of style sheet of (paragraph i of selection)
				
				
				if a = first_style then
					
					set style sheet of (paragraph (i + 1)) of selection to next_style
				end if
			end try
			
		end repeat
		
		
	end tell
	display dialog "Done"
	
end tell


