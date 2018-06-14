(*
	Copyright (c) Espen Moe-Nilssen
	Make tabs
*)


tell application "QuarkXPress 2017"
	activate
	tell document 1
		set move_tab to text returned of (display dialog "Move Tabs by" default answer 5)
		tell selection
			repeat with j from 1 to count of paragraphs
				set a to tab list of paragraph j
				set tabrecord to {} as list
				repeat with i from 1 to count of items of a
					set b to item i of a
					set just to justification of b
					set posit to position of b
					set posit to posit as millimeter units
					set posit to posit as string
					set posit to word 1 of posit
					set posit to posit as number
					set newposit to posit + move_tab
					set filler to fill character of b
					copy {justification:just, fill character:filler, position:newposit} to end of tabrecord
				end repeat
				
				set tab list of paragraph j to tabrecord
				--display dialog j
			end repeat
		end tell
	end tell
	display dialog "Done"
end tell
