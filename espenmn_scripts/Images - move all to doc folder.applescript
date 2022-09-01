(*
	Move all images to same folder as Quark Xpress document
*)



(*
	A script to  only show RGB image
	It will supress printing for all others
*)


tell application "QuarkXPress 2018"
	activate
	set doc_path to file path of document 1
	tell document 1
		repeat with i from 1 to count of picture boxes
			tell picture box i
				try
					set image_path to file path of image 1 as string
					
					set image_name to name of image 1 as string
					
					tell application "Finder"
						beep
						set doc_container to (container of (doc_path))
						move alias image_path to folder (doc_container as string)
					end tell
					
				on error
					--display dialog "Could not move file" buttons "OK" default button "OK"
					--beep
				end try
				
			end tell
		end repeat
		display dialog "Done"
	end tell
end tell





