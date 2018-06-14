(*
	Remove empty lines
*)


tell application "QuarkXPress 2017"
	activate
	
	tell selection
		repeat with i from (count of paragraphs) to 1 by -1
			-- display dialog (count of characters of paragraph i)
			if (count of characters of paragraph i) = 1 then
				delete paragraph i
			end if
		end repeat
		display dialog "DONE"
	end tell
end tell
