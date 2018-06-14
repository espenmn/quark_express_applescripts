(*
	importing eps files with imposition
	Use the applescipt 'Save each page as EPS to generate the EPS files'
	You probably want to make the first image box in the right bottom corner and duplicate it from there
*)

tell application "QuarkXPress 2017"
	activate
	
	
	set theFolder to choose folder with prompt "Pick a folder from which to auto-import the images."
	
	
	set question to display dialog "Pages" default answer 10
	set totalpages to text returned of question
	
	set question to display dialog "Imageboxes on each page" default answer 10
	set imageboxes to text returned of question
	
	set question to display dialog "Image base name (without _00X.eps)" default answer "Project 1"
	set imagename to text returned of question
	
	
	repeat with p from 0 to totalpages
		repeat with i from 0 to imageboxes
			
			
			tell picture box (i + 1) of page p of document 1
				set tall to ((i * totalpages) + p) as string
				
				set FilePath1 to (theFolder & imagename & "_" & tall & ".eps") as string
				set FilePath2 to (theFolder & imagename & "_0" & tall & ".eps") as string
				set FilePath3 to (theFolder & imagename & "_00" & tall & ".eps") as string
				
				try
					set image 1 to FilePath1 as alias
				end try
				try
					set image 1 to FilePath2 as alias
				end try
				try
					set image 1 to FilePath3 as alias
				end try
			end tell
		end repeat
	end repeat
	
end tell