(*
	A script to change every occurence of '-' (hyphen( between two numbers to "Ð"
*)

tell application "QuarkXPress 2017"
	activate
	tell document 1
		-- display dialog (count of characters of selection)
		set antall to count of characters of selection
		repeat with i from 3 to antall
			
			if character i of selection is in "0123456789" then
				if character (i - 1) of selection is "-" then
					if character (i - 2) of selection is in "0123456789" then
						set character (i - 1) of selection to "Ð"
						set color of character (i - 1) of selection to "Magenta"
					end if
				end if
			end if
			--set progress completed steps to i
		end repeat
		display dialog "Done"
	end tell
end tell


