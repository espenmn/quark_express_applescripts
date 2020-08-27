tell application "QuarkXPress 2018"
	activate
	tell document 1
		repeat with i from 1 to count of pages
			tell page i
				move picture box 1 to front
			end tell
			try
				set yheight to height of bounds of picture box 1 of page i
				set top of bounds of text box 1 of page i to "30mm"
				set height of bounds of text box 1 of page i to yheight
			end try
		end repeat
	end tell
	display dialog "Done"
end tell