set outputfolderpath to (choose folder with prompt "Choose Text Output Folder" without invisibles) as text

tell application "QuarkXPress 2017"
	activate
	set a to text export filters
	set min_length to text returned of (display dialog "Smallest text to export" default answer 3)
	repeat with i from 1 to count of documents
		set quarkfilename to name of document i
		tell document 1
			repeat with j from 1 to count of text boxes
				--try
				set txtbox to object reference of text box j
				if (the length of (story 1 of txtbox) > min_length) then save (story 1 of txtbox) as "XPress Tags" in file ((outputfolderpath & (quarkfilename & j & ".xtg")) as text)
				--end try
			end repeat
		end tell
	end repeat
end tell