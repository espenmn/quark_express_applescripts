tell application "QuarkXPress 2018"
	activate
	tell document 1
		tell current page
			set pheight to height of bounds
			set page_height to (word 1 of pheight as integer)
			tell current box
				set bheight to height of bounds
				set box_height to (word 1 of bheight as integer)
				set diff to page_height - box_height + 3
				set top of bounds to diff
				set height of bounds to box_height
			end tell
		end tell
	end tell
end tell