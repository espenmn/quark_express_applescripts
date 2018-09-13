tell application "QuarkXPress 2018"
	repeat with jj from 2 to 7
		set missing_link_list to {}
		repeat with i from 1 to (count every image of document 1)
			set missing_status to missing of image i of document 1
			if missing_status is true then
				set missing_image_path to file path of image i of document 1
				try
					tell application "Finder"
						set oldDels to AppleScript's text item delimiters
						set AppleScript's text item delimiters to ":"
						set n to the number of text items in missing_image_path
						set missing_link_name to text items n thru end of missing_image_path as string
						set missing_path_name to text items jj thru end of missing_image_path as string
						set AppleScript's text item delimiters to oldDels
					end tell
					set ny_path to "Volumes:data:Documents:#Fra Jobber:" & missing_path_name as string
				end try
				--display dialog ny_path
				try
					set image i of document 1 to ny_path as alias
				end try
			end if
		end repeat
		
		
	end repeat
	display dialog "Done"
end tell