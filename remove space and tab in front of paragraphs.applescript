(*
	A script to remove 'spaces in front of paragraphs'
*)

tell application "QuarkXPress 2017"
	activate
	tell document 1
		display dialog (count of paragraphs of selection)
		
		repeat with i from 1 to count of paragraphs of selection
			if first character of paragraph i of selection is "	" or first character of paragraph i of selection is "	" then
				set first character of paragraph i of selection to ""
			end if
		end repeat
		
	end tell
end tell


