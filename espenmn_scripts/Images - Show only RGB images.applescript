(*
	A script to  only show RGB image
	It will supress printing for all others
*)

tell application "QuarkXPress 2018"
	activate
	tell document 1
		repeat with i from 1 to count of picture boxes
			tell picture box i
				set imageName to file path of image 1 as string
				display dialog imageName
				tell application "Image Events"
					set check to 0
								
					set theFile to imageName as alias
					set this_image to open theFile
					set color_space to color space of this_image
					close this_image
					set color_space to color_space as string
					
					if color_space = "RGB" then
						set check to 1
											
					end if
					
				end tell
							
				if check = 1 then set suppress printing to 1
				
			end tell
		end repeat
		--display dialog "Done"
	end tell
end tell


