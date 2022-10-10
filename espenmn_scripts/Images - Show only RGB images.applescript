(*
	A script to  only show RGB image
	It will supress printing for all others
*)

global check
tell application "QuarkXPress 2018"
	activate
	tell document 1
		repeat with i from 1 to count of picture boxes
			tell picture box i
				set imageName to file path of image 1 as string
				set suppress printing to 0
				set check to 0
				tell application "Image Events"
					--set check to 0
					
					try
						
						set theFile to imageName as alias
						set this_image to open theFile
						set color_space to color space of this_image
						close this_image
						set color_space to color_space as string
						
						if color_space = "CMYK" then
							set check to 1
						end if
						
					end try
					
				end tell
				
				--display dialog check
				if check is 0 then set suppress printing to 1
			end tell
		end repeat
		--display dialog "Done"
	end tell
end tell


