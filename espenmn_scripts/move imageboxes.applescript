tell application "QuarkXPress 2017"
	activate
	
	tell document 1
		set mylist to {}
		set a to display dialog "Left pages" default answer "10, 10"
		set b to text returned of a
		set c to display dialog "Right pages" default answer "20, 20"
		set d to text returned of c
		repeat with i from 1 to count of pages
			set whichside to i mod 2
			--display dialog whichside
			if whichside = 1 then
				set cBoxBounds to b
			else
				set cBoxBounds to d
			end if
			try
				tell picture box 1 of page i
					set yheight to height of bounds
					set xwidth to width of bounds
					set left of bounds to (word 1 of cBoxBounds as integer)
					set top of bounds to (word 2 of cBoxBounds as integer)
					set height of bounds to yheight
					set width of bounds to xwidth
					
				end tell
			end try
		end repeat
	end tell
end tell