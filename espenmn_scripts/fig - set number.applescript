

tell application "QuarkXPress 2018"
	activate
	set mynumber to 1
	tell document 1
		repeat with i from 1 to count of text boxes
			tell text box i
				--try
				--	set color of paragraph 1 to "Cyan" --i
				--end try
				try
					if word 1 of paragraph 1 is "Figure" then
						try
							set color of paragraph 1 to "Magenta"
							set contents of last word of paragraph 1 to mynumber
							-- set contents of  word 2 of paragraph 1 to mynumber
							set mynumber to mynumber + 1
						end try
						
					end if
					
				end try
			end tell
		end repeat
	end tell
end tell


