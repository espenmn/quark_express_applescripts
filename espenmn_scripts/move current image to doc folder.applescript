
tell application "QuarkXPress 2018"
	activate
	tell document 1
		-- display dialog (count of characters of selection)
		set antall to count of characters of selection
		repeat with i from 1 to antall
			if base shift of character i of selection is not "0 pt" then
				set color of character i of selection to "Magenta"
				
			end if
			--set progress completed steps to i
		end repeat
		display dialog "Done"
	end tell
end tell
