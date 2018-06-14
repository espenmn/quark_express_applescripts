(*
	Copyright (c) Espen Moe-Nilssen
	export every story of every document as Word text
*)

set outputfolderpath to (choose folder with prompt "Choose Text Output Folder" without invisibles) as text

tell application "QuarkXPress 2017"
	activate
	set a to text export filters
	repeat with i from 1 to 50
		set quarkfilename to name of document i
		tell document 1
			repeat with j from 1 to count of text boxes
				try
					set txtbox to object reference of text box j
					
					save (story 1 of txtbox) as "Word Document" in file ((outputfolderpath & (quarkfilename & j & ".docx")) as text)
				end try
			end repeat
		end tell
	end repeat
end tell