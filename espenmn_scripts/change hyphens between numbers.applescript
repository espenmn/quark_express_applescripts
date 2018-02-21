(*
	A script to change every occurence of '-' (hyphen( between two numbers to "Ð"
*)
tell application "QuarkXPress 2017"
	activate
	tell document 1
		display dialog (count of words of selection)
		
		repeat with i from 3 to count of characters of selection
			
			if character i of selection is in "0123456789" then
				if character (i - 1) of selection is "-" then
					if character (i - 2) of selection is in "0123456789" then
						set character (i - 1) of selection to "Ð"
					end if
				end if
			end if
		end repeat	
		display dialog "Done"
	end tell
end tell


