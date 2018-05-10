tell application "QuarkXPress 2017"
	set missing_link_list to {}
	repeat with i from 1 to (count every image of document 1)
		set missing_status to missing of image i of document 1
		if missing_status is true then
			set missing_image_path to file path of image i of document 1
			tell application "Finder"
				set oldDels to AppleScript's text item delimiters
				set AppleScript's text item delimiters to ":"
				set n to the number of text items in missing_image_path
				set missing_link_name to text items n thru end of missing_image_path as string
				set AppleScript's text item delimiters to oldDels
			end tell
			set missingthing to missing_link_name & return
			copy missingthing to the end of missing_link_list
		end if
	end repeat
	set missing_link_list to missing_link_list as string
	display dialog missing_link_list
	
end tell