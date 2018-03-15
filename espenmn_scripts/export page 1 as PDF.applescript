set outputfolderpath to (choose folder with prompt "Choose PDFOutput Folder" without invisibles) as text
tell application "QuarkXPress 2017"
	
	set quarkfilename to name of document 1
	set filename to outputfolderpath & quarkfilename & ".pdf" as text
	tell document 1
		
		export page 1 as "PDF" in ((outputfolderpath & (quarkfilename) & ".pdf") as text) PDF output style "kast"
	end tell
end tell