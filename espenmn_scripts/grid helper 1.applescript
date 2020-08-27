tell application "QuarkXPress 2018"
	activate
	tell document 1
		set countBoxes to count of picture boxes
		repeat with i from 1 to countBoxes
			--move picture box i to front
		end repeat
		repeat with i from countBoxes to 1 by -1
			try
				move picture box i of page 1 to front of page (countBoxes - i + 1)
			end try
		end repeat
	end tell
	display dialog "Done"
end tell