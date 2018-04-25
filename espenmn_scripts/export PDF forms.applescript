(*
	CopyrightÊ(c)Ê12017 Espen Moe-Nilssen
	This script saves a document in 'several PDF'
	Useful for impositin etc.
	espen at medialog dot no	
*)

set outputfolderpath to (choose folder with prompt "Choose PDFOutput Folder" without invisibles) as text
tell application "QuarkXPress 2017"
	set my_input to display dialog "From" default answer 1
	set x to text returned of my_input
	set my_input to display dialog "To" default answer (count of pages of document 1)
	set y to text returned of my_input
	set my_input to display dialog "pages in form" default answer 16
	set step_by to text returned of my_input
	set quarkfilename to name of document 1
	repeat with i from x to y by step_by
		set j to i + step_by - 1
		if j > y then set j to y
		set pagerange to i & "-" & j
		tell document 1
			
			export page range (pagerange as text) as "PDF" in ((outputfolderpath & (quarkfilename) & "_" & pagerange & ".pdf") as text) PDF output style "gilberg"
		end tell
	end repeat
end tell