(*
    Opens all images from a Quark  Xpress  document
	So you can color correct, convert to CMYK etc.
	For reasons unknown, you need to run the script a few times to open all images
	Copyright (c) Espen Moe-Nilssen
*)

tell application "QuarkXPress 2017"
	activate
	
	repeat with j from 1 to 3
		tell document 1
			repeat with i from 1 to (count of picture boxes)
				try
					set foundPictBoxes to object reference of picture box i
					--  set a to image type of image 1 of foundPictBoxes
					--  display dialog (a as string)
					try
						set imageName to file path of image 1 of foundPictBoxes
						
						--delay 0.3
						
						tell application "Finder"
							try
								open imageName
							on error
								--beep
							end try
						end tell
					on error
						--beep
					end try
				on error
					--beep
				end try
			end repeat
		end tell
	end repeat
	
end tell