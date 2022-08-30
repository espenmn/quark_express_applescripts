(*
	A script to find images with no file on disk
*)

tell application "QuarkXPress 2018"
	activate
	tell document 1
		set question to display dialog "Hide 'OK images' or show all" buttons {"Cancel", "Hide OK images", "Show all"} default button "Hide OK images"
		set svar to button returned of question
		
		
		
		repeat with i from 1 to count of picture boxes
			tell picture box i
				if svar is "Show all" then
					set suppress printing to 0
				else
					set image_path to file path of image 1 as string
					
					if image_path is not "no disk file" then set suppress printing to 1
					if  missing of image 1  then  set suppress printing to 0
					
				end if
			end tell
		end repeat
		--display dialog "Done"
	end tell
end tell


