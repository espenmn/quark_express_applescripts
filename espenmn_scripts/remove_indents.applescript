(*
	A script that sets indent to 0 if:
	fist indent (first line) indent is more than 8
	
	or
	left indent is more than 8
	
	or
	the paragraph above is a newline
	
	
*)


tell application "QuarkXPress 2017"
	activate
	tell document 1
		display dialog (count of paragraphs of selection)
		repeat with i from 2 to count of paragraphs of selection
			set c to length of (paragraph (i - 1) of selection)
			-- display dialog c
			tell paragraph i of selection
				set a to left indent
				set a to word 1 of a as number
				set b to first indent
				set b to word 1 of b as number
				
				if a > 8 or b > 8 or c = 1 then
					set left indent to 0
					set first indent to 0
					set color to "cyan"
				end if
				
			end tell
		end repeat
	end tell
end tell