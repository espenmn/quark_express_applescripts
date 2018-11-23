tell application "QuarkXPress 2018"
	activate
	
	tell document 1
		
		set a to display dialog "Move imageboxes down by" default answer "10mm"
		set b to text returned of a
		repeat with i from 1 to count of pages
			try
			tell picture box 1 of page i
				set yheight to height of bounds
				--set xwidth to width of bounds
				--set xleft to left of bounds
				set ytop to top of bounds
				set yytop to ytop as string
				set ytop to yytop & "+" & b
				
				--display dialog ytop
				set top of bounds to ytop
				set height of bounds to yheight
				--set width of bounds to xwidth
				
			end tell
			end try
		end repeat
	end tell
end tell