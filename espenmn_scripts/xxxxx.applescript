(*
	CopyrightÊ(c)Ê1986Ê-Ê2016ÊQuarkÊSoftware Inc.
	AllÊRightsÊReserved
	Quark Software Inc. & Nyhthawk Productions
	http://www.Quark.com
	http://members.aol.com/nyhthawk/welcome.html

	Copying and sharing of this script in whole or in part is allowed.  The authors are 
	not responsible for any losses caused by the use of or failure of this software.
*)

tell application "QuarkXPress 2018"
	activate
	try
		-- This line will ensure a document is open
		if not (exists document 1) then error "No document is open."
		
		-- This line ensures a box is selected
		if not (exists current box) then error "No box is selected." & return & "Select a box, then run this script again."
		
		tell document 1
			-- This line will display an error if the current page is a master page
			if masterdoc is true then error "This script doesn't work on master pages."
			
			--set hm to horizontal measure
			--set vm to vertical measure
			--set horizontal measure to points
			--set vertical measure to points
			set oldCoords to item spread coords
			set item spread coords to false
			set oldOrigin to page rule origin
			set page rule origin to {0, 0}
			
			set pagenumber to the page number of page 1 of the current box
			
			--The following if's determine which kind of boxes to create
			if box type of current box = picture box type then
				set MyBoxType to picture box
			else if box type of current box = text box type and box shape of current box is not in {line shape, orthogonal line, spline line} then
				set MyBoxType to text box
			else if box type of current box = graphic box type and box shape of current box is not in {line shape, orthogonal line, spline line} then
				set MyBoxType to graphic box
			else
				error "The single; text box, picture box, or none box, must be selected."
			end if
		end tell
		
		-- The following section will get the bounds to use for the grid, and then convert all the values to points
		set boxBounds to bounds of current box as list
		set a to ((item 1 of boxBounds) as point units) as real
		set b to ((item 2 of boxBounds) as point units) as real
		set c to ((item 3 of boxBounds) as point units) as real
		set d to ((item 4 of boxBounds) as point units) as real
		
		set OBW to (d - b) --Old Box Width
		set OBH to (c - a) --Old Box Height
		
		
		tell document 1
			-- This line will get the page width of the document
			set pw to ((page width as point units) as real)
			-- This line will get the color of the current box
			set boxColor to color of current box
			set boxColorName to name of color of current box
			
			(* Get the number of columns *)
			repeat -- This repeat statement will keep repeating until the user enters an integer
				set theCols to (display dialog "How many columns?" & return & "Whole numbers only. Partial boxes are not available." default answer "" buttons {"Cancel", "OK"} default button "OK")
				-- For compatibility with non-US English operating systems
				if button returned of theCols is "Cancel" then error "User canceled." number -128
				set NumOfColumns to text returned of theCols
				try
					set NumOfColumns to NumOfColumns as integer
					if NumOfColumns is less than or equal to 0 then error
					exit repeat
				on error
					beep
					display dialog "The number of columns must be a whole number greater than 0." buttons {"OK"} default button 1 with icon caution
				end try
			end repeat
			
			(* Get the number of rows *)
			repeat -- This repeat statement will keep repeating until the user enters an integer
				set theRows to (display dialog "How many rows?" & return & "Whole numbers only. Partial boxes are not available." default answer "" buttons {"Cancel", "OK"} default button "OK")
				-- For compatibility with non-US English operating systems
				if button returned of theRows is "Cancel" then error "User canceled." number -128
				set NumOfRows to text returned of theRows
				try
					set NumOfRows to NumOfRows as integer
					if NumOfRows is less than or equal to 0 then error
					exit repeat
				on error
					beep
					display dialog "The number of rows must be a whole number greater than 0." buttons {"OK"} default button 1 with icon caution
				end try
			end repeat
			
			(* Get the column gutter height *)
			repeat -- This repeat will ensure the value is within range
				repeat -- This repeat will ensure the user enters a valid measurement
					set dialogResult to (display dialog "Column gutter measurement" & return & return & Â
						"Examples: .5\", 3p, 36 pt, etc." & return & Â
						"The default value type is " & (horizontal measure as text) & "." default answer "0" buttons {"Cancel", "OK"} default button "OK")
					-- For compatibility with non-US English operating systems
					if button returned of dialogResult is "Cancel" then error "User canceled." number -128
					set CGut to text returned of dialogResult
					try
						set CGut to ((CGut as horizontal measurement) as point units) as real --will have QuarkXPress do a conversion
						if CGut < 0 then error
						exit repeat
					on error
						beep
						display dialog "The value you entered, \"" & text returned of dialogResult & "\", is not a valid measurement." buttons {"Cancel", "Try Again"} default button 2
						-- For compatibility with non-US English operating systems
						if button returned of result is "Cancel" then error "User canceled." number -128
					end try
				end repeat
				--number of gutters = (NumOfColumns or NumOfRows - 1) 
				-- Ensure that the column gutter width will work with the box size
				if ((NumOfColumns - 1) * CGut) < OBW then
					exit repeat
				else
					beep
					display dialog "The requested column gutter measurement is too large." & return & Â
						"The value must be less than: " & ((((OBW - (6 * NumOfColumns)) / (NumOfColumns - 1) as point units) as horizontal measurement) as text) buttons {"Cancel", "Try again"} default button 2
					--note that the 6 in (OBW - (6 * NumOfColumns)) makes sure that the minimum size box is 6 points
					-- For compatibility with non-US English operating systems
					if button returned of result is "Cancel" then error "User canceled." number -128
				end if
			end repeat
			
			(* Get the row gutter width *)
			repeat -- This repeat will ensure the value is within range
				repeat -- This repeat will ensure the user enters a valid measurement
					set dialogResult to (display dialog "Row gutter measurement" & return & return & Â
						"Examples: .5\", 3p, 36 pt, etc." & return & Â
						"The default value type is " & (vertical measure as text) & "." default answer "0" buttons {"Cancel", "OK"} default button "OK")
					-- For compatibility with non-US English operating systems
					if button returned of dialogResult is "Cancel" then error "User canceled." number -128
					set RGut to text returned of dialogResult
					try
						set RGut to ((RGut as vertical measurement) as point units) as real
						if RGut < 0 then error
						exit repeat
					on error
						beep
						display dialog "The value you entered, \"" & text returned of dialogResult & "\", is not a valid measurement." buttons {"Cancel", "Try Again"} default button 2
						-- For compatibility with non-US English operating systems
						if button returned of result is "Cancel" then error "User canceled." number -128
					end try
				end repeat
				-- Ensure that the row gutter width will work with the box size
				if ((NumOfRows - 1) * RGut) < OBH then
					exit repeat
				else
					beep
					display dialog "The requested row gutter measurement is too large." & return & Â
						"The value should be less than: " & ((((OBH - (6 * NumOfRows)) / (NumOfRows - 1) as point units) as vertical measurement) as text) buttons {"Cancel", "Try again"} default button 2
					-- For compatibility with non-US English operating systems
					if button returned of result is "Cancel" then error "User canceled." number -128
				end if
			end repeat
		end tell
		
		-- This section will display a dialog notifying the user that it may take a long time, if the cell count exceeds 100
		-- It may take upwards of 5 minutes for cell counts greater than 500
		set theMsg to ""
		if NumOfColumns * NumOfRows > 1000 then
			set theMsg to "This may take a very long time. If you would like to continue, now would be a good time for a break?"
		else if NumOfColumns * NumOfRows > 500 then
			set theMsg to "This may take a very long time. Would you like to continue?"
		else if NumOfColumns * NumOfRows > 100 then
			set theMsg to "This may take a while. Would you like to continue?"
		end if
		if theMsg ­ "" then
			display dialog theMsg buttons {"Cancel", "OK"} default button "OK"
			if button returned of result is "Cancel" then error "User canceled." number -128
		end if
		
		set OBWD to (((d - b) + CGut) / NumOfColumns) --Old Box Width Divided
		set OBHD to (((c - a) + RGut) / NumOfRows) --Old Box Height Divided
		
		set NBW to (OBWD - CGut) --New Box Width including the gutters
		set NBH to (OBHD - RGut) --New Box Height including the gutters
		
		if d < pw then --if the selected box is smaller than the width of the page thenÉ
			set theContainer to page 1 of current box
		else
			set theContainer to spread 1 of current box
		end if
		
		-- This section will create the boxes/cells
		tell theContainer
			repeat with q from NumOfRows - 1 to 0 by -1 --builds vertically
				repeat with i from NumOfColumns - 1 to 0 by -1 --builds horizontally
					make new MyBoxType at beginning with properties Â
						{bounds:{(a + (OBHD * q)) as point units, (b + (OBWD * i)) as point units, (a + ((NBH * q) + NBH) + (RGut * q)) as point units, (b + ((NBW * i) + NBW) + (CGut * i)) as point units}, color:boxColor}
				end repeat
			end repeat
		end tell
		
		-- Determine if the text boxes should be linked, and if so, link them
		if MyBoxType = text box then
			display dialog "Do you want all the text boxes linked together?" buttons {"No", "Yes"} default button "Yes"
			if button returned of result is "Yes" then
				tell theContainer
					repeat with i from 1 to ((NumOfRows * NumOfColumns) - 1)
						set next text box of text box i to text box (i + 1)
					end repeat
				end tell
			end if
		end if
		
		-- This section will create the guides around the cells
		display dialog "Do you want guides attached to the boxes?" buttons {"No", "Yes"} default button "Yes"
		if button returned of result = "Yes" then
			if d < pw then -- if the right of the box is less than the page width
				tell page pagenumber of document 1
					if RGut > 0 then
						repeat with q from 0 to NumOfRows - 1
							make horizontal guide at beginning with properties {position:(a + (OBHD * q)) as point units}
						end repeat
					else
						make horizontal guide at beginning with properties {position:a as point units}
					end if
					repeat with q from 1 to NumOfRows
						make horizontal guide at beginning with properties {position:(a + ((NBH * q) + (RGut * (q - 1)))) as point units}
					end repeat
					if CGut > 0 then
						repeat with i from 0 to NumOfColumns - 1
							make vertical guide at beginning with properties {position:(b + (OBWD * i)) as point units}
						end repeat
					else
						make vertical guide at beginning with properties {position:b as point units}
					end if
					repeat with i from 1 to NumOfColumns
						make vertical guide at beginning with properties {position:(b + ((NBW * i) + (CGut * (i - 1)))) as point units}
					end repeat
				end tell
			else -- theContainer is set to current spread
				set completeboxesonfirstpage to ((pw - b) / (NBW + CGut))
				set completeboxesonfirstpage to (round completeboxesonfirstpage rounding down)
				
				set PageAvertRepeat to completeboxesonfirstpage
				set PageBstartPoint to (OBW + b) - pw
				
				set completeboxesonSecondpage to (PageBstartPoint / (NBW + CGut))
				set completeboxesonSecondpage to (round completeboxesonSecondpage rounding down)
				
				set PageBvertRepeat to completeboxesonSecondpage
				
				tell page pagenumber of document 1
					if RGut > 0 then
						repeat with q from 0 to NumOfRows - 1
							make horizontal guide at beginning with properties {position:(a + (OBHD * q)) as point units}
						end repeat
					else
						make horizontal guide at beginning with properties {position:a as point units}
					end if
					repeat with q from 1 to NumOfRows
						make horizontal guide at beginning with properties {position:(a + ((NBH * q) + (RGut * (q - 1)))) as point units}
					end repeat
					if CGut > 0 then
						repeat with i from 0 to PageAvertRepeat
							make vertical guide at beginning with properties {position:(b + (OBWD * i)) as point units}
						end repeat
					else
						make vertical guide at beginning with properties {position:b as point units}
					end if
					repeat with i from 1 to PageAvertRepeat
						make vertical guide at beginning with properties {position:(b + ((NBW * i) + (CGut * (i - 1)))) as point units}
					end repeat
				end tell
				
				tell page (pagenumber + 1) of document 1
					if RGut > 0 then
						repeat with q from 0 to NumOfRows - 1
							make horizontal guide at beginning with properties {position:(a + (OBHD * q)) as point units}
						end repeat
					else
						make horizontal guide at beginning with properties {position:a as point units}
					end if
					repeat with q from 1 to NumOfRows
						make horizontal guide at beginning with properties {position:(a + ((NBH * q) + (RGut * (q - 1)))) as point units}
					end repeat
					if CGut > 0 then
						repeat with i from 1 to PageBvertRepeat
							make vertical guide at beginning with properties {position:(PageBstartPoint - ((NBW * i) + (CGut * (i - 1)))) as point units}
						end repeat
					end if
					repeat with i from 0 to PageBvertRepeat
						make vertical guide at beginning with properties {position:(PageBstartPoint - (OBWD * i)) as point units}
					end repeat
				end tell
			end if
		end if
		
		tell document 1
			--set horizontal measure to hm
			--set vertical measure to vm
			set item spread coords to oldCoords
			set page rule origin to oldOrigin
		end tell
		
		-- The following beep will provide feedback of script completion
		beep 2
	on error errmsg number errnum
		try -- This try is used for the event that an error is being generated due to the lack of an open document
			tell document 1
				--set horizontal measure to hm
				--set vertical measure to vm
				set item spread coords to oldCoords
				set page rule origin to oldOrigin
			end tell
		end try
		
		if errnum is not -128 then
			beep
			display dialog errmsg & " [" & errnum & "]" buttons {"OK"} default button 1 with icon stop
		end if
		return
	end try
end tell


