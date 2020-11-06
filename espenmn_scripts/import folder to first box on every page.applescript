 

tell application "QuarkXPress 2018"
	activate
	
	try
		-- This line will ensure that a document is open, before proceeding
		if not (exists document 1) then error "No document is open."
		
		-- This line will display an error if the current page is a master page
		if masterdoc of document 1 is true then error "This script doesn't work on master pages."
		
		tell document 1
			
			-- This line will ask the user to select the folder which contains the desired images
			set theFolder to choose folder with prompt "Pick a folder from which to auto-import the images."
			
			
			
			-- This section will ask the user to specify if the images should be imported at 100% or if they should be auto fit to the box
			set fitOptions to {"Leave 100%", "Fit to Box", "Fit to Box (Proportionally)", "Fit Box to Picture", "Fit to Largest Percent"}
			set autoFitImages to (choose from list fitOptions with prompt "How should the images be scaled?" default items {"Fit to Box (Proportionally"})
			-- For compatibility with non-US English operating systems
			if autoFitImages is false then error "User canceled." number -128
			set autoFitImages to item 1 of autoFitImages
			
			try
				tell application "Finder"
					-- This section will make a list of the images that are in the specified folder
					set theImageList to every file of theFolder whose kind is not "alias" and Â
						file type is "TIFF" or name extension is "TIF" or Â
						file type is "EPSF" or name extension is "EPS" or Â
						file type is "PICT" or Â
						file type is "JPEG" or name extension is "JPG" or name extension is "JPEG" or Â
						file type is "GIFf" or name extension is "GIF" or Â
						file type is "BMP " or name extension is "BMP" or Â
						file type is "RIFF" or name extension is "RIF" or Â
						file type is "BINA" or Â
						file type is "PNTG" or name extension is "PNG" or Â
						file type is "BMPf"
					
					-- This line will ensure that the class of the variable is a list. The following repeat is expecting a list
					if class of theImageList is not list then set theImageList to theImageList as list
				end tell
			on error
				error "No images were found in this folder."
			end try
			
			-- This section configures variables that will be used in the following repeat statement
			set theNumberOfImages to number of items of theImageList
			set theCounter to 1
			
			-- This repeat statement performs the bulk of the work
			repeat with i from 1 to count of pages
				-- This line imports the image, from the folder, into the picture box
				set image 1 of picture box 1 of page i to (item i of theImageList) as alias
				
				-- This section will automatically fit the image to the picture box, if specified by the user, to do so
				if autoFitImages is not "Leave 100%" then
					if autoFitImages is "Fit to Box" then
						set bounds of image 1 of picture box 1 of page i to exact fit
					else if autoFitImages is "Fit to Box (Proportionally)" then
						set bounds of image 1 of picture box 1 of page i to proportional fit
					else if autoFitImages is "Fit Box to Picture" then
						set bounds of image 1 of picture box 1 of page i to box fit
					else if autoFitImages is "Fit to Largest Percent" then
						try
							set bounds of image 1 of picture box 1 of page i to exact fit
							copy (scale of image 1 of picture box 1 of page i as list) to {imageHeight, imageWidth}
							copy {imageHeight as real, imageWidth as real} to {imageHeight, imageWidth}
							
							--AUTO FIT THE IMAGE TO THE PICTURE BOX
							if imageWidth > imageHeight then
								set newPercent to imageWidth
							else
								set newPercent to imageHeight
							end if
							set scale of image 1 of picture box 1 of page i to {newPercent, newPercent}
							set bounds of image 1 of picture box 1 of page i to centered
						on error errmsg number errnum
							error errmsg number errnum
						end try
					end if
				end if
				
				-- This if statement will exit the repeat statement, if there are no more images to import
				if i = theNumberOfImages then
					exit repeat
				end if
			end repeat
		end tell
		-- The following beep will provide feedback of script completion
		beep 2
	on error errmsg number errnum
		if errnum ­ -128 then
			beep
			display dialog errmsg & " [" & errnum & "]" buttons {"OK"} default button 1 with icon stop
		end if
		-- For compatibility with non-US English operating systems
		return
	end try
end tell