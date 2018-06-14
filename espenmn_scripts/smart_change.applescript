tell application "QuarkXPress 2017"
	-- remove loop if we get checkboxes
	repeat with j from 1 to 12
		-- need check boxes for this
		set question to display dialog "Change what" buttons {"Stop", "Color", "Font"} default button 1
		set answer to button returned of question
		set answer to answer as text
		
		if answer = "Stop" then
			exit repeat
		end if
		
		
		tell document 1
			repeat with i from 1 to (count of paragraphs of selection)
				
				display dialog i
				try
					set style_name to name of style sheet of paragraph i of selection
					--set style_name to paragraph attributes of style_name
					--display dialog style_name
					
					if answer = "Font" then
						--display dialog "we will font you"
						set real_font to font of style specs
						set font of paragraph i of selection to real_font
						
					end if
					
					display dialog i
					if answer = "Color" then
						-- display dialog "we will colorize you"
						set real_color to color of style specs
						set color of paragraph i of selection to real_color
						
					end if
				end try
				
			end repeat
		end tell
		
	end repeat
	
end tell


