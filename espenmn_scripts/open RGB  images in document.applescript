(*
    Opens all RGB images from a Quark  Xpress  document
	So you can color correct, convert to CMYK etc.
	 Copyright (c) Espen Moe-Nilssen
*)

set theList to {}
tell application "QuarkXPress 2018"
	activate
	
	
	tell document 1
		repeat with i from 1 to (count of picture boxes)
			
			set foundPictBoxes to object reference of picture box i
			--  set a to image type of image 1 of foundPictBoxes
			--  display dialog (a as string)
			
			try
				set imageName to file path of image 1 of foundPictBoxes
				tell application "Image Events"
					set theFile to imageName as alias
					set this_image to open theFile
					set color_space to color space of this_image
					close this_image
					
				end tell
				
				set color_space to color_space as string
				if color_space = "RGB color info" then
					copy imageName to end of theList
				end if
				
			on error
				beep
			end try
			
		end repeat
	end tell
end tell

tell application "Finder"
	repeat with i from 1 to count of theList
		
		open item i of theList
	end repeat
	
end tell