(*
	Move  all images to same folder as Quark Xpress document
	¨ Espen Moe-Nilssen, 2020
*)

tell application "QuarkXPress 2018"
	set doc_path to file path of document 1
	tell document 1
		repeat with i from 1 to count of picture boxes
			try
				set image_path to file path of image 1 of picture box i as string
				set image_name to name of image 1 of picture box i as string
				tell application "Finder"
					set doc_container to (container of (doc_path))
					move alias image_path to folder (doc_container as string)
				end tell
			on error
				-- display dialog "Could not move file " & image_name buttons "OK" default button "OK"
			end try
		end repeat
	end tell
	display dialog "Finished Moving images" buttons "OK" default button "OK"
end tell