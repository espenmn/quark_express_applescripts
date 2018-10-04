(*
	Copyright (c) 1986 - 2016 Quark Software Inc.
	All Rights Reserved
	Quark Software Inc. & Nyhthawk Productions
	http://www.Quark.com
	http://members.aol.com/nyhthawk/welcome.html

	Copying and sharing of this script in whole or in part is allowed.  The authors are 
	not responsible for any losses caused by the use of or failure of this software.
*)

property RegColor : "Registration"

tell application "QuarkXPress 2018"
	activate
	
	try
		-- This line will check to make sure a document is open, before proceeding
		if (exists document 1) is false then error "No document is open."
		
		tell document 1
			-- This line will display an error if the current page is a master page
			if masterdoc is true then error "This script doesn't work on master pages."
			
			-- This line makes sure that the script can work with the selected box
			if (exists current box) is false then error "A single box must be selected."
			
			-- Confirm the color exist -- used for compatibility with Passport languages
			if not (exists color spec RegColor) then
				set RegColor to name of color spec 1 whose registration color is true
			end if
			
			--Copy the object reference of the current box into a variable so we can refer to it again
			set theBox to object reference of current box
			
			--Get the page number of the page the current box is on
			
			
			
			
			--the various crop mark parameters. To adjust the look of the crop marks simply change these values.
			set lineWidth to 0.5
			set lineLength to 24
			set lineOffset to 6
			
			tell current page
				
				repeat with a from 1 to count of picture boxes
					--get the bounds of the current box
					--box bounds reads as {A (y1),B (x1),C (y2),D (x2)}
					
					set theBox to picture box a
					
					set BoxA to top of bounds of theBox as point units as real --converts everything to points and a number (no "pts")
					set BoxB to left of bounds of theBox as point units as real
					set BoxC to bottom of bounds of theBox as point units as real
					set BoxD to right of bounds of theBox as point units as real
					
					--top or left point is first and reads {A,B}
					--top left corner vertical line
					make line box at beginning with properties {start point:{BoxA - lineLength, BoxB} as points point, end point:{BoxA - lineOffset, BoxB} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					--top right corner vertical line. Note that the line width must be taken into account
					make line box at beginning with properties {start point:{BoxA - lineLength, BoxD} as points point, end point:{BoxA - lineOffset, BoxD} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					--bottom left corner vertical line
					make line box at beginning with properties {start point:{BoxC + lineOffset, BoxB} as points point, end point:{BoxC + lineLength, BoxB} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					--bottom right corner vertical line. Note that the line width must be taken into account
					make line box at beginning with properties {start point:{BoxC + lineOffset, BoxD} as points point, end point:{BoxC + lineLength, BoxD} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					--top left corner horizontal line
					make line box at beginning with properties {start point:{BoxA, BoxB - lineOffset} as points point, end point:{BoxA, BoxB - lineLength} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					--top right corner horizontal line
					make line box at beginning with properties {start point:{BoxA, BoxD + lineOffset} as points point, end point:{BoxA, BoxD + lineLength} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					--bottom left corner horizontal line. Note that the line width must be taken into account
					make line box at beginning with properties {start point:{BoxC, BoxB - lineOffset} as points point, end point:{BoxC, BoxB - lineLength} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					--bottom right corner horizontal line. Note that the line width must be taken into account
					make line box at beginning with properties {start point:{BoxC, BoxD + lineOffset} as points point, end point:{BoxC, BoxD + lineLength} as points point, width:lineWidth, color:RegColor, box shape:orthogonal line}
					
					-- The following beeps notify the user that the script is complete
					
				end repeat
				beep 2
			end tell
		end tell
	on error errmsg number errnum
		if errnum ≠ -128 then
			beep
			display dialog errmsg & " [" & errnum & "]" buttons {"OK"} default button 1 with icon stop
		end if
		-- For compatibility with non-US English operating systems
		return
	end try
end tell