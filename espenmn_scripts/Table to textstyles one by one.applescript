(*
	Copyright (c) 12017 Espen Moe-Nilssen
	This script takes a table and coverts it to "Stylesheets"
	Do like this: 
	1) Make a new document
	2) Copy / paste a table from Excel or whatever
	3) Name the first row with the stylesheet name you want to use
	4) Add and select a new text box AND write some text in it
	5) Run the script
	6) Run the 'Convert to tags script (due to copyright I could not include it)	
*)

tell application "QuarkXPress 2018"
	tell document 1
		set exporttext to "<v13.21><e8>"
		set headertext to {}
		set mybox to table box 1
		set tbcolumn to count of table column of mybox
		repeat with j from 1 to tbcolumn
			set end of headertext to (story 1 of (text cell j of mybox))
		end repeat
		-- set tcount to count of table rows of mybox
		set tcount to count of text cells of mybox
		
		repeat with i from 1 to tcount
			set cellcontent to story 1 of (text cell i of mybox)
			set columnnr to (i mod tbcolumn)
			if columnnr = 0 then set columnnr to tbcolumn
			if i > tbcolumn then
				set firste to "@" & (item columnnr of headertext) & ":"
				set seconde to cellcontent & return
				copy firste to after story 1
				copy seconde to after story 1
				
			end if
		end repeat
		
		display dialog "Now, select the text and run the 'Convert from Xpress Tags Script'"
		
	end tell
end tell
