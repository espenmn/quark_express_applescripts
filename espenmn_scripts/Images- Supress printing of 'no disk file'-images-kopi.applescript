(*
	A script to find images with no file on disk
*)

tell application "QuarkXPress 2018"
	activate
	tell document 1
		repeat with i from 1 to count of picture boxes
			tell picture box i
				-- set suppress printing to 1
				set image_path to file path of image 1 as string
				--if image_path is "no disk file" then set suppress printing to 1
				if image_path is not "no disk file" then set suppress printing to 1
				
				
			end tell
		end repeat
		--display dialog "Done"
	end tell
end tell


