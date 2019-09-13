(*
	Move selected image to same folder as Quark Xpress document
*)

tell application "QuarkXPress 2018"
	try
		set image_path to file path of image 1 of current box as string
		set image_name to name of image 1 of current box as string
		set doc_path to file path of document 1
		tell application "Finder"
			set doc_container to (container of (doc_path))
			move alias image_path to folder (doc_container as string)
		end tell
		display dialog "Moved file: " & image_name & "to folder:" & (doc_container as string) buttons "OK"
		
	on error
		display dialog "Could not move file" buttons "OK"
	end try
end tell